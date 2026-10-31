#!/usr/bin/env python3
"""Offline pcapng inspection and loss-aware TCP reassembly (stdlib only).

Run: python3 analysis/pcap_inspect.py capture.pcapng
Outputs are confined to analysis/pcap_*; inputs are opened read-only.
TCP exports never silently concatenate across sequence-number gaps.
"""

import argparse
import collections
import hashlib
import io
import ipaddress
import json
import math
import struct
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

CIPHERS = {
    0x1301: 'TLS_AES_128_GCM_SHA256', 0x1302: 'TLS_AES_256_GCM_SHA384',
    0x1303: 'TLS_CHACHA20_POLY1305_SHA256',
    0xc02b: 'TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256',
    0xc02c: 'TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384',
    0xc02f: 'TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256',
    0xc030: 'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384',
    0xcca8: 'TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256',
    0xcca9: 'TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256',
    0x009c: 'TLS_RSA_WITH_AES_128_GCM_SHA256',
    0x009d: 'TLS_RSA_WITH_AES_256_GCM_SHA384',
}
GROUPS = {23: 'secp256r1', 24: 'secp384r1', 25: 'secp521r1', 29: 'x25519', 30: 'x448', 256: 'ffdhe2048'}


def options(data, endian):
    result = []
    pos = 0
    while pos + 4 <= len(data):
        code, size = struct.unpack_from(endian + 'HH', data, pos)
        pos += 4
        if code == 0:
            break
        if pos + size > len(data):
            raise ValueError('Truncated pcapng option')
        value = data[pos:pos + size]
        result.append({'code': code, 'hex': value.hex(), 'text': value.decode('utf-8', 'replace')})
        pos += (size + 3) & ~3
    return result


def pcapng_packets(path, metadata, out):
    endian = '<'
    interfaces = []
    section = -1
    frame = 0
    with path.open('rb') as handle:
        while True:
            offset = handle.tell()
            head = handle.read(12)
            if not head:
                break
            if len(head) != 12:
                raise ValueError(f'Truncated block header at {offset}')
            if head[:4] == b'\x0a\x0d\x0d\x0a':
                if head[8:12] == b'\x4d\x3c\x2b\x1a':
                    endian = '<'
                elif head[8:12] == b'\x1a\x2b\x3c\x4d':
                    endian = '>'
                else:
                    raise ValueError('Invalid pcapng byte-order magic')
            kind, length = struct.unpack_from(endian + 'II', head)
            if length < 12 or length % 4 or length > 64 * 1024 * 1024:
                raise ValueError(f'Invalid block length {length} at {offset}')
            block = head + handle.read(length - 12)
            if len(block) != length or struct.unpack_from(endian + 'I', block, length - 4)[0] != length:
                raise ValueError(f'Truncated/inconsistent block at {offset}')
            body = block[8:-4]
            metadata['block_counts'][f'0x{kind:08x}'] += 1
            if kind == 0x0a0d0d0a:
                section += 1
                interfaces = []
                metadata['sections'].append({'index': section, 'endian': endian, 'options': options(body[16:], endian)})
            elif kind == 1:
                link, _, snap = struct.unpack_from(endian + 'HHI', body)
                opts = options(body[8:], endian)
                resolution = 1e-6
                time_offset = 0
                for opt in opts:
                    val = bytes.fromhex(opt['hex'])
                    if opt['code'] == 9 and val:
                        resolution = (2 if val[0] & 128 else 10) ** -(val[0] & 127)
                    elif opt['code'] == 14 and len(val) == 8:
                        time_offset = struct.unpack(endian + 'q', val)[0]
                interface = {'section': section, 'id': len(interfaces), 'linktype': link, 'snaplen': snap,
                             'timestamp_resolution': resolution, 'timestamp_offset': time_offset, 'options': opts}
                interfaces.append(interface)
                metadata['interfaces'].append(interface)
            elif kind in (6, 2):
                if len(body) < 20:
                    raise ValueError('Truncated packet block')
                if kind == 6:
                    iface, high, low, caplen, origlen = struct.unpack_from(endian + 'IIIII', body)
                else:
                    iface, _, high, low, caplen, origlen = struct.unpack_from(endian + 'HHIIII', body)
                if iface >= len(interfaces) or caplen > len(body) - 20:
                    raise ValueError('Invalid packet interface or length')
                info = interfaces[iface]
                frame += 1
                timestamp = ((high << 32) | low) * info['timestamp_resolution'] + info['timestamp_offset']
                if caplen < origlen:
                    metadata['truncated_frames'].append(frame)
                packet_opts = options(body[20 + ((caplen + 3) & ~3):], endian)
                for opt in packet_opts:
                    if opt['code'] == 1:
                        metadata['packet_comments'].append({'frame': frame, 'comment': opt['text']})
                yield frame, timestamp, info['linktype'], body[20:20 + caplen]
            elif kind == 3:
                if not interfaces:
                    raise ValueError('Simple packet without interface')
                origlen = struct.unpack_from(endian + 'I', body)[0]
                caplen = min(origlen, interfaces[0]['snaplen'] or origlen, len(body) - 4)
                frame += 1
                yield frame, None, interfaces[0]['linktype'], body[4:4 + caplen]
            elif kind == 10:
                secret_type, size = struct.unpack_from(endian + 'II', body)
                secret = body[8:8 + size]
                filename = f'pcap_secrets_{len(metadata["secrets"]):03d}_{secret_type:08x}.bin'
                (out / filename).write_bytes(secret)
                metadata['secrets'].append({'type': f'0x{secret_type:08x}', 'length': size, 'file': filename,
                                            'text': secret.decode('utf-8', 'replace')})
    metadata['packet_count'] = frame


def network_packet(linktype, data):
    if linktype == 1:
        if len(data) < 14:
            return None
        protocol = struct.unpack_from('!H', data, 12)[0]
        pos = 14
        while protocol in (0x8100, 0x88a8, 0x9100):
            if pos + 4 > len(data):
                return None
            protocol = struct.unpack_from('!H', data, pos + 2)[0]
            pos += 4
        if protocol not in (0x0800, 0x86dd):
            return None
        data = data[pos:]
    elif linktype == 113:
        data = data[16:]
    elif linktype == 276:
        data = data[20:]
    elif linktype not in (101, 228, 229):
        return None
    if not data:
        return None
    version = data[0] >> 4
    if version == 4:
        if len(data) < 20:
            return None
        ihl = (data[0] & 15) * 4
        total = struct.unpack_from('!H', data, 2)[0]
        if ihl < 20 or total < ihl or len(data) < ihl:
            return None
        fragments = struct.unpack_from('!H', data, 6)[0]
        src = str(ipaddress.ip_address(data[12:16]))
        dst = str(ipaddress.ip_address(data[16:20]))
        return src, dst, data[9], data[ihl:total], bool(fragments & 0x3fff), total > len(data)
    if version == 6:
        if len(data) < 40:
            return None
        src = str(ipaddress.ip_address(data[8:24]))
        dst = str(ipaddress.ip_address(data[24:40]))
        end = 40 + struct.unpack_from('!H', data, 4)[0]
        protocol = data[6]
        pos = 40
        fragmented = False
        while protocol in (0, 43, 44, 51, 60):
            if pos + 2 > len(data):
                return None
            next_protocol = data[pos]
            if protocol == 44:
                if pos + 8 > len(data):
                    return None
                fragmented = bool(struct.unpack_from('!H', data, pos + 2)[0] & 0xfff9)
                size = 8
            elif protocol == 51:
                size = (data[pos + 1] + 2) * 4
            else:
                size = (data[pos + 1] + 1) * 8
            pos += size
            protocol = next_protocol
        return src, dst, protocol, data[pos:end], fragmented, end > len(data)
    return None


def entropy(data):
    if not data:
        return 0
    counts = collections.Counter(data)
    return round(-sum((n / len(data)) * math.log2(n / len(data)) for n in counts.values()), 4)


def sample(data, size=128):
    prefix = data[:size]
    return {'hex': prefix.hex(), 'ascii': ''.join(chr(c) if 32 <= c < 127 else '.' for c in prefix),
            'entropy': entropy(data), 'sha256': hashlib.sha256(data).hexdigest()}


def reassemble(segments, initial_seq=None):
    if not segments:
        return [], {'captured_payload_bytes': 0, 'unique_payload_bytes': 0, 'overlap_bytes': 0,
                    'conflicting_overlap_bytes': 0, 'gaps': [], 'sequence_origin': initial_seq}
    reference = initial_seq if initial_seq is not None else segments[0][0]
    def relative(seq):
        return ((seq - reference + 0x80000000) & 0xffffffff) - 0x80000000
    ordered = sorted((relative(seq), frame, data) for seq, frame, data in segments)
    chunks = []
    start = None
    buffer = bytearray()
    overlap = conflicts = 0
    gaps = []
    if initial_seq is not None and ordered[0][0] > 0:
        gaps.append({'start_relative': 0, 'end_relative': ordered[0][0], 'length': ordered[0][0]})
    for offset, frame, payload in ordered:
        if start is None:
            start = offset
        end = start + len(buffer)
        if offset > end:
            chunks.append((start, bytes(buffer)))
            gaps.append({'start_relative': end, 'end_relative': offset, 'length': offset - end})
            start, buffer = offset, bytearray(payload)
        elif offset < end:
            count = min(end - offset, len(payload))
            existing = buffer[offset - start:offset - start + count]
            overlap += count
            conflicts += sum(a != b for a, b in zip(existing, payload[:count]))
            buffer.extend(payload[count:])
        else:
            buffer.extend(payload)
    if buffer:
        chunks.append((start, bytes(buffer)))
    return chunks, {'captured_payload_bytes': sum(len(p) for _, _, p in segments),
                    'unique_payload_bytes': sum(len(p) for _, p in chunks), 'overlap_bytes': overlap,
                    'conflicting_overlap_bytes': conflicts, 'gaps': gaps, 'sequence_origin': reference,
                    'overlap_policy': 'lowest sequence start, then earliest frame; retain first bytes'}


def tls_extensions(data, pos):
    result = []
    if pos + 2 > len(data):
        return result
    end = pos + 2 + int.from_bytes(data[pos:pos + 2], 'big')
    pos += 2
    while pos + 4 <= min(end, len(data)):
        kind, size = struct.unpack_from('!HH', data, pos)
        value = data[pos + 4:pos + 4 + size]
        item = {'type': kind, 'length': size, 'hex': value.hex()}
        if kind == 0 and len(value) >= 5:
            item['server_name'] = value[5:5 + int.from_bytes(value[3:5], 'big')].decode('ascii', 'replace')
        elif kind == 16 and len(value) >= 2:
            alpn = []
            at = 2
            while at < len(value):
                size2 = value[at]
                alpn.append(value[at + 1:at + 1 + size2].decode('ascii', 'replace'))
                at += size2 + 1
            item['alpn'] = alpn
        elif kind == 43:
            item['supported_versions_hex'] = value.hex()
        elif kind == 51:
            # ServerHello has one share; ClientHello has a length-prefixed vector.
            at = 0 if len(value) >= 4 and int.from_bytes(value[2:4], 'big') == len(value) - 4 else 2
            shares = []
            while at + 4 <= len(value):
                group, keylen = struct.unpack_from('!HH', value, at)
                shares.append({'group': GROUPS.get(group, f'0x{group:04x}'),
                               'public_key_hex': value[at + 4:at + 4 + keylen].hex()})
                at += 4 + keylen
            item['key_shares'] = shares
        result.append(item)
        pos += 4 + size
    return result


def tls_hello(kind, body):
    if len(body) < 35:
        return {'error': 'short hello'}
    result = {'type': 'ClientHello' if kind == 1 else 'ServerHello', 'legacy_version_hex': body[:2].hex(),
              'random_hex': body[2:34].hex()}
    session_len = body[34]
    result['session_id_hex'] = body[35:35 + session_len].hex()
    pos = 35 + session_len
    if kind == 1:
        size = int.from_bytes(body[pos:pos + 2], 'big')
        pos += 2
        result['cipher_suites'] = [CIPHERS.get(int.from_bytes(body[i:i + 2], 'big'), f'0x{int.from_bytes(body[i:i + 2], "big"):04x}')
                                   for i in range(pos, min(pos + size, len(body)) - 1, 2)]
        pos += size
        if pos >= len(body):
            return result
        pos += 1 + body[pos]
    else:
        if pos + 3 > len(body):
            return result
        cipher = int.from_bytes(body[pos:pos + 2], 'big')
        result['cipher_suite'] = CIPHERS.get(cipher, f'0x{cipher:04x}')
        pos += 3
    result['extensions'] = tls_extensions(body, pos)
    return result


def inspect_application(data) -> dict[str, Any]:
    if data.startswith(b'SSH-'):
        return {'protocol': 'SSH', 'identification': data.split(b'\r\n', 1)[0].decode('ascii', 'replace')}
    if data.startswith((b'GET ', b'POST ', b'PUT ', b'HEAD ', b'HTTP/', b'CONNECT ')):
        header = data.split(b'\r\n\r\n', 1)[0][:8192]
        return {'protocol': 'HTTP', 'headers': header.decode('latin1')}
    if len(data) >= 5 and data[0] in (20, 21, 22, 23) and data[1] == 3 and data[2] <= 4:
        records = []
        hellos = []
        handshake = bytearray()
        pos = 0
        encrypted = False
        while pos + 5 <= len(data):
            kind, version, size = struct.unpack_from('!BHH', data, pos)
            if kind not in (20, 21, 22, 23, 24) or version >> 8 != 3 or size > 18432:
                break
            end = pos + 5 + size
            records.append({'offset': pos, 'content_type': kind, 'version_hex': f'{version:04x}',
                            'length': size, 'complete': end <= len(data)})
            if end > len(data):
                break
            if kind == 22 and not encrypted:
                handshake.extend(data[pos + 5:end])
                while len(handshake) >= 4:
                    htype = handshake[0]
                    hsize = int.from_bytes(handshake[1:4], 'big')
                    if len(handshake) < hsize + 4:
                        break
                    hbody = bytes(handshake[4:4 + hsize])
                    if htype in (1, 2):
                        hellos.append(tls_hello(htype, hbody))
                    else:
                        hellos.append({'handshake_type': htype, 'length': hsize, 'body_hex': hbody.hex()})
                    del handshake[:4 + hsize]
            if kind == 20:
                encrypted = True
            pos = end
        return {'protocol': 'TLS', 'record_count': len(records), 'records': records, 'handshakes': hellos,
                'parsed_bytes': pos, 'unparsed_bytes': len(data) - pos}
    if data.startswith(b'PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n'):
        return {'protocol': 'HTTP/2 cleartext'}
    return {'protocol': 'unclassified'}


def dns_name(data, pos, seen=None):
    seen = set() if seen is None else seen
    labels = []
    end = None
    while pos < len(data):
        if pos in seen:
            raise ValueError('DNS compression loop')
        seen.add(pos)
        size = data[pos]
        pos += 1
        if size == 0:
            return '.'.join(labels), end if end is not None else pos
        if size & 0xc0 == 0xc0:
            if pos >= len(data):
                raise ValueError('DNS pointer truncated')
            target = ((size & 63) << 8) | data[pos]
            name, _ = dns_name(data, target, seen)
            labels.append(name)
            return '.'.join(labels), end if end is not None else pos + 1
        if size > 63 or pos + size > len(data):
            raise ValueError('DNS label truncated')
        labels.append(data[pos:pos + size].decode('ascii', 'replace'))
        pos += size
    raise ValueError('DNS name truncated')


def inspect_dns(data):
    if len(data) < 12:
        return None
    ident, flags, qd, an, ns, ar = struct.unpack_from('!6H', data)
    pos = 12
    result = {'id': ident, 'flags_hex': f'{flags:04x}', 'questions': [], 'answers': []}
    try:
        for _ in range(qd):
            name, pos = dns_name(data, pos)
            kind, cls = struct.unpack_from('!HH', data, pos)
            pos += 4
            result['questions'].append({'name': name, 'type': kind, 'class': cls})
        for _ in range(an + ns + ar):
            name, pos = dns_name(data, pos)
            kind, cls, ttl, size = struct.unpack_from('!HHIH', data, pos)
            pos += 10
            value = data[pos:pos + size]
            item = {'name': name, 'type': kind, 'class': cls, 'ttl': ttl, 'hex': value.hex()}
            if kind in (1, 28) and len(value) in (4, 16):
                item['address'] = str(ipaddress.ip_address(value))
            elif kind in (2, 5, 12):
                item['target'], _ = dns_name(data, pos)
            result['answers'].append(item)
            pos += size
    except (ValueError, struct.error) as exc:
        result['error'] = str(exc)
    return result


def inspect_http(data, out, stem):
    header, separator, remainder = data.partition(b'\r\n\r\n')
    if not separator:
        return {'error': 'missing complete header'}
    rows = header.decode('latin1').split('\r\n')
    headers = []
    for row in rows[1:]:
        if ':' in row:
            name, value = row.split(':', 1)
            headers.append([name, value.strip()])
    lookup = {name.lower(): value for name, value in headers}
    result = {'first_line': rows[0], 'headers': headers, 'body_offset': len(header) + 4,
              'captured_body_length': len(remainder)}
    if 'transfer-encoding' in lookup:
        result['transfer_encoding'] = lookup['transfer-encoding']
        result['warning'] = 'Transfer-coded body exported verbatim, not decoded'
    if 'content-length' in lookup:
        size = int(lookup['content-length'])
        result['declared_body_length'] = size
        result['content_length_matches'] = len(remainder) == size
        body = remainder[:size]
        result['trailing_bytes'] = max(0, len(remainder) - size)
    else:
        body = remainder
        result['framing'] = 'connection close (no Content-Length/Transfer-Encoding)'
    filename = stem + '_body.bin'
    (out / filename).write_bytes(body)
    result['body_file'] = filename
    result['body_length'] = len(body)
    result['body_sample'] = sample(body)
    return result


def inspect_dhcp(data):
    if len(data) < 240 or data[236:240] != b'\x63\x82\x53\x63':
        return None
    result = {'operation': data[0], 'transaction_id_hex': data[4:8].hex(),
              'client_address': str(ipaddress.ip_address(data[12:16])),
              'your_address': str(ipaddress.ip_address(data[16:20])), 'options': []}
    pos = 240
    while pos < len(data):
        kind = data[pos]
        pos += 1
        if kind == 255:
            break
        if kind == 0:
            continue
        if pos >= len(data):
            break
        size = data[pos]
        value = data[pos + 1:pos + 1 + size]
        pos += 1 + size
        item = {'type': kind, 'hex': value.hex()}
        if kind in (12, 15, 60):
            item['text'] = value.decode('ascii', 'replace')
        elif kind == 53 and value:
            item['message_type'] = {1: 'DISCOVER', 2: 'OFFER', 3: 'REQUEST', 5: 'ACK', 7: 'RELEASE'}.get(value[0], value[0])
        elif kind in (1, 3, 6, 54) and len(value) % 4 == 0:
            item['addresses'] = [str(ipaddress.ip_address(value[i:i + 4])) for i in range(0, len(value), 4)]
        result['options'].append(item)
    return result


def xor_bytes(a, b):
    return bytes(x ^ y for x, y in zip(a, b))


def catthief_protocol(inventory, out):
    """Capture-specific hypotheses; raw exports remain independent of these."""
    exchanges = []
    for flow in inventory['tcp']:
        client = flow['client_direction']
        if client is None:
            continue
        requests = flow['directions'][client]['chunks']
        responses = flow['directions'][1 - client]['chunks']
        if len(requests) != 1 or len(responses) != 1:
            continue
        request = requests[0]['application'].get('http')
        response = responses[0]['application'].get('http')
        if not request or not response or request['first_line'] != 'POST /exfil HTTP/1.1':
            continue
        exchanges.append((flow, request, response))
    if len(exchanges) != 6:
        return {'status': 'capture-specific six-exchange pattern not present'}
    exchanges.sort(key=lambda entry: entry[0]['first_frame'])
    bootstrap = (out / exchanges[0][1]['body_file']).read_bytes()
    if len(bootstrap) != 264:
        return {'status': 'initial POST is not 264 bytes'}
    report = {'status': 'offline evidence and explicitly tentative hypotheses',
              'transport': 'cleartext HTTP, not TLS',
              'public_keys_or_master_keys': 'none positively identified in the protocol',
              'bootstrap_body_file': exchanges[0][1]['body_file'], 'exchanges': [],
              'known_plaintext_assumption': 'Response path uses the standard Windows Users directory spelling; '
                  'XOR against the bootstrap shows Us%rs, corrected by XOR 0x40 at offset 5.',
              'filename_sequence_inference': 'The response to each POST selects the path for the NEXT POST. '
                  'Initial POST is probably a bootstrap/probe; final response has no body.',
              'compression_hypothesis': 'Under an unverified zero-filled-bootstrap assumption, the 256 candidate '
                  'symbol lengths cluster around 7-11, suggesting Huffman-like coding. This is not a confirmed '
                  'codec, and no JPEG plaintext has been recovered.'}
    pad = bytearray(bootstrap)
    pad[5] ^= 0x40
    known_pad = {}
    paths = []
    for flow, request, response in exchanges:
        ciphertext = (out / response['body_file']).read_bytes()
        raw_xor = xor_bytes(ciphertext, bootstrap)
        if ciphertext and not raw_xor.startswith(b'c:\\Us%rs\\flare\\Desktop\\'):
            return {'status': 'expected filename-XOR pattern not present'}
        probable_path = xor_bytes(ciphertext, pad)
        paths.append(probable_path.decode('ascii'))
        for offset, value in enumerate(xor_bytes(ciphertext, probable_path)):
            if offset in known_pad and known_pad[offset] != value:
                raise ValueError('Inconsistent filename-derived pad')
            known_pad[offset] = value
        if probable_path:
            (out / f'pcap_http_{flow["id"]:04d}_response_path_candidate.txt').write_text(
                probable_path.decode('ascii') + '\n', encoding='utf-8')
        report['exchanges'].append({'stream_id': flow['id'], 'client': endpoint_text(flow['endpoints'][flow['client_direction']]),
            'server': endpoint_text(flow['endpoints'][1 - flow['client_direction']]),
            'first_frame': flow['first_frame'], 'last_frame': flow['last_frame'],
            'start_utc': datetime.fromtimestamp(flow['first_timestamp'], timezone.utc).isoformat(),
            'request_body_file': request['body_file'], 'request_body_length': request['body_length'],
            'request_body_sha256': request['body_sample']['sha256'],
            'response_body_file': response['body_file'], 'response_body_length': response['body_length'],
            'response_ciphertext_hex': ciphertext.hex(), 'response_xor_bootstrap_ascii': raw_xor.decode('ascii'),
            'next_requested_path_candidate': probable_path.decode('ascii')})
    prefix = bytes(known_pad[i] for i in range(len(known_pad)))
    (out / 'pcap_response_keystream_prefix.bin').write_bytes(prefix)
    (out / 'pcap_xor_pad_candidate.bin').write_bytes(pad)
    report['response_keystream_prefix'] = {'file': 'pcap_response_keystream_prefix.bin', 'length': len(prefix),
        'hex': prefix.hex(), 'warning': 'Known-plaintext-derived XOR pad, not a recovered master key. '
        'All five paths share the same first 23 ciphertext bytes; longest path gives 40 pad bytes. '
        'The extension to 264 bytes assumes the bootstrap is zero except offset 5 = 0x40.'}
    report['extended_pad_candidate_file'] = 'pcap_xor_pad_candidate.bin'
    report['extended_pad_warning'] = ('Bytes beyond the 40-byte prefix are not verified keystream. '
        'The initial POST is NOT proven to contain a public key or a literal cryptographic key.')
    report['probe_header_rule'] = ('(int.from_bytes(request_body[:8] XOR candidate_pad[:8], big) >> 21) '
        '== request_body_length - 262 for all six requests; this is an empirical framing invariant.')
    for index, ((flow, request, response), entry) in enumerate(zip(exchanges, report['exchanges'])):
        body = (out / request['body_file']).read_bytes()
        clear_probe = xor_bytes(body, pad)
        filename = f'pcap_http_{flow["id"]:04d}_prefix_xor_probe.bin'
        (out / filename).write_bytes(clear_probe)
        shifted = bytes([clear_probe[0] >> 5] + [
            ((clear_probe[i - 1] & 31) << 3) | (clear_probe[i] >> 5) for i in range(1, len(clear_probe))])
        header_value = int.from_bytes(clear_probe[:8], 'big') >> 21
        lengths = shifted[6:262]
        tablefile = f'pcap_http_{flow["id"]:04d}_symbol_lengths_candidate.bin'
        (out / tablefile).write_bytes(lengths)
        entry['uploaded_path_candidate'] = paths[index - 1] if index else '(bootstrap/probe)'
        entry['prefix_xor_probe_file'] = filename
        entry['prefix_xor_probe_hex'] = clear_probe[:40].hex()
        entry['empirical_header_value'] = header_value
        entry['header_rule_matches'] = header_value == len(body) - 262
        entry['symbol_lengths_candidate_file'] = tablefile
        entry['symbol_lengths_histogram'] = dict(collections.Counter(lengths))
        entry['candidate_table_kraft_sum'] = sum(2.0 ** -length for length in lengths if length)
    report['next_steps'] = [
        ('In a separate, static-only executable-analysis scope, locate /exfil and ureq call sites; '
         'recover request compression/framing and response transform. Do not execute the binary.'),
        ('Validate the candidate XOR pad against known filename responses and the all-six header rule. '
         'Determine whether the transform resets a stream generator on every request/response, and recover '
         'its actual key/seed or full pad; 40 inferred bytes (264 speculative) cannot decrypt multi-MB uploads.'),
        ('Apply the confirmed transform and codec to the five exported request bodies, in order, starting '
         'with stream 0001 (important.jpg). Validate JPEG SOI/EOI and decoded structure before claiming recovery.')
    ]
    (out / 'pcap_protocol.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    lines = ['# Offline catthief packet analysis', '',
             '## Confirmed capture/transport facts',
             f'- Capture SHA-256: `{inventory["metadata"]["capture_sha256"]}`.',
             '- 2,810 packets; six TCP connections, three UDP flow pairs. No TLS/SSH handshake or embedded pcapng secrets.',
             '- All six TCP connections go from 192.168.56.103 to 192.168.56.102:8080.',
             '- Every TCP direction has a captured SYN, no sequence gaps, no retransmitted payload bytes, and no conflicting overlaps.',
             '- HTTP/1.1 POST /exfil; User-Agent ureq/2.12.1; all six Content-Length values exactly match capture.',
             '- Responses are HTTP/1.0 200 OK, BaseHTTP/0.6 Python/3.8.10, close-delimited binary bodies.',
             '- Five nonempty responses (36, 37, 40, 36, 40 bytes), followed by one empty response.',
             '- No positively identified public key, master key, nonce, or standard cipher negotiation.', '',
             '## Filename/keystream inference',
             '- XOR(response body, initial POST body prefix) yields `c:\\Us%rs\\flare\\Desktop\\...` for all five responses.',
             '- Assuming normal `Users` spelling corrects byte 5 by XOR 0x40 and gives the paths below.',
             '- Responses appear to select the NEXT upload: the first POST is a 264-byte bootstrap/probe.',
             '- `pcap_response_keystream_prefix.bin` contains 40 inferred XOR pad bytes, NOT a master key.',
             '- `pcap_xor_pad_candidate.bin` extends this to 264 bytes under an unverified zero-filled-bootstrap assumption.',
             '- First 40 pad bytes: `' + prefix.hex() + '`.', '',
             '| Stream | Client port | Frames | POST body bytes | Probable uploaded file |',
             '|---|---:|---|---:|---|']
    for entry in report['exchanges']:
        path = entry['uploaded_path_candidate'].rsplit('\\', 1)[-1]
        lines.append(f'| {entry["stream_id"]:04d} | {entry["client"].rsplit(":", 1)[-1]} | '
                     f'{entry["first_frame"]}-{entry["last_frame"]} | {entry["request_body_length"]:,} | `{path}` |')
    lines += ['', '## Empirical request framing and tentative compression clue',
              '- With the candidate XOR pad, `(big_endian_u64(first_8_bytes) >> 21) == POST_body_length - 262` in all six uploads.',
              '- Initial decoded prefix: `' + report['exchanges'][0]['prefix_xor_probe_hex'] + '`.',
              '- Stream 0001 decoded prefix: `' + report['exchanges'][1]['prefix_xor_probe_hex'] + '`.',
              '- Shifting the 264-byte probe right by five bits exposes a 256-byte candidate symbol-length table at bytes 6..261.',
              ('Candidate lengths predominantly 8, with 7/9/10/11 and one 6. This suggests Huffman-like coding, '
               'but candidate Kraft sums are not 1 and the full format is unverified. Do not treat these files as decoded JPEGs.'),
              '', '## UDP/background traffic',
              '- 192.168.56.103:68 <-> 192.168.56.100:67: DHCP REQUEST/ACK (302/548 payload bytes).',
              '- fe80::988a:9121:5600:5fd6:64869 -> ff02::1:3:5355: two LLMNR queries, FLARE-VM, type ANY.',
              '- 192.168.56.103:64869 -> 224.0.0.252:5355: two LLMNR queries, FLARE-VM, type ANY.',
              '- Other packets: IPv6 ICMP, IGMP, and six ARP/non-IP Ethernet frames.', '', '## Outputs',
              ('- `pcap_inventory.json`, `pcap_summary.txt`: pcapng metadata, exact endpoints, SYN/FIN state, '
               'reassembly accounting, HTTP and UDP metadata, hashes, payload samples.'),
              '- `pcap_tcp_0000..0005_{a_to_b,b_to_a}.bin`: twelve raw, contiguous directional TCP streams.',
              ('- `pcap_http_0000..0005_{request,response}_body.bin`: HTTP-header-free binary bodies; '
               'request 0000 is the bootstrap, requests 0001..0005 are the probable file uploads.'),
              ('- `pcap_protocol.json`: inference details, candidate file order, per-body SHA-256, framing checks, '
               'response hex, code-length histograms.'),
              '- `pcap_udp_0000..0002.bin`: lossless datagrams in documented framed containers.',
              '', '## Concrete next steps']
    lines.extend(f'{index + 1}. {step}' for index, step in enumerate(report['next_steps']))
    (out / 'pcap_protocol_report.md').write_text('\n'.join(lines) + '\n', encoding='utf-8')
    return report


def endpoint_text(endpoint):
    address, port = endpoint
    return f'[{address}]:{port}' if ':' in address else f'{address}:{port}'


def analyze(capture, out):
    capture_hash = hashlib.sha256(capture.read_bytes()).hexdigest()
    metadata = {'capture': str(capture), 'capture_size': capture.stat().st_size, 'capture_sha256': capture_hash,
                'sections': [], 'interfaces': [],
                'block_counts': collections.Counter(), 'secrets': [], 'truncated_frames': [], 'packet_comments': []}
    tcp_flows = []
    active = {}
    udp_flows = {}
    network_counts = collections.Counter()
    issues = collections.Counter()
    for frame, timestamp, link, packet in pcapng_packets(capture, metadata, out):
        parsed = network_packet(link, packet)
        if parsed is None:
            issues['non_IP_or_unsupported_linktype'] += 1
            continue
        src, dst, protocol, payload, fragmented, truncated = parsed
        network_counts[str(protocol)] += 1
        if fragmented:
            issues['fragmented_IP_skipped'] += 1
            continue
        if truncated:
            issues['truncated_IP'] += 1
        if protocol == 6 and len(payload) >= 20:
            sport, dport, seq, ack = struct.unpack_from('!HHII', payload)
            header_size = (payload[12] >> 4) * 4
            flags = payload[13]
            if header_size < 20 or header_size > len(payload):
                issues['invalid_TCP_header'] += 1
                continue
            a, b = sorted(((src, sport), (dst, dport)))
            key = (a, b)
            direction = 0 if (src, sport) == a else 1
            flow = active.get(key)
            new_syn = bool(flags & 2 and not flags & 16)
            if flow is None or (new_syn and flow['syn_seq'][direction] not in (None, seq)):
                flow = {'id': len(tcp_flows), 'endpoints': [a, b], 'first_frame': frame, 'last_frame': frame,
                        'first_timestamp': timestamp, 'last_timestamp': timestamp, 'packets': [0, 0],
                        'wire_payload_bytes': [0, 0], 'flags': [collections.Counter(), collections.Counter()],
                        'syn_seq': [None, None], 'syn_frame': [None, None], 'fin_seq': [None, None],
                        'control_packets': [], 'segments': [[], []], 'client_direction': None}
                tcp_flows.append(flow)
                active[key] = flow
            flow['last_frame'] = frame
            flow['last_timestamp'] = timestamp
            flow['packets'][direction] += 1
            flow['flags'][direction][f'0x{flags:02x}'] += 1
            if flags & 2:
                flow['syn_seq'][direction] = seq
                flow['syn_frame'][direction] = frame
            if new_syn:
                flow['client_direction'] = direction
            data = payload[header_size:]
            if flags & 7:
                flow['control_packets'].append({'frame': frame, 'direction': direction, 'seq': seq, 'ack': ack,
                    'flags_hex': f'0x{flags:02x}', 'tcp_options_hex': payload[20:header_size].hex()})
            if flags & 1:
                flow['fin_seq'][direction] = (seq + len(data) + bool(flags & 2)) & 0xffffffff
            if data:
                flow['segments'][direction].append(((seq + bool(flags & 2)) & 0xffffffff, frame, data))
                flow['wire_payload_bytes'][direction] += len(data)
        elif protocol == 17 and len(payload) >= 8:
            sport, dport, length, _checksum = struct.unpack_from('!HHHH', payload)
            a, b = sorted(((src, sport), (dst, dport)))
            key = (a, b)
            direction = 0 if (src, sport) == a else 1
            if key not in udp_flows:
                udp_flows[key] = {'id': len(udp_flows), 'endpoints': [a, b], 'first_frame': frame, 'last_frame': frame,
                                  'packets': [0, 0], 'payload_bytes': [0, 0], 'datagrams': []}
            flow = udp_flows[key]
            flow['last_frame'] = frame
            flow['packets'][direction] += 1
            data = payload[8:length]
            flow['payload_bytes'][direction] += len(data)
            flow['datagrams'].append((frame, timestamp, direction, data))
        elif protocol in (6, 17):
            issues['short_transport_header'] += 1
    metadata['network_protocol_counts'] = dict(network_counts)
    metadata['issues'] = dict(issues)
    inventory = {'metadata': metadata, 'tcp': [], 'udp': []}
    lines = [f'Capture: {capture.name} ({metadata["capture_size"]} bytes)',
             f'Packets: {metadata["packet_count"]}; TCP flows: {len(tcp_flows)}; UDP flows: {len(udp_flows)}',
             f'Network protocols: {dict(network_counts)}; issues: {dict(issues)}',
             f'Embedded secrets: {len(metadata["secrets"])}', '', 'TCP flows:']
    for flow in tcp_flows:
        segments = flow.pop('segments')
        flow['directions'] = []
        lines.append(f'TCP {flow["id"]:04d}: {endpoint_text(flow["endpoints"][0])} <-> {endpoint_text(flow["endpoints"][1])} '
                     f'frames={flow["first_frame"]}-{flow["last_frame"]} packets={flow["packets"]}')
        for direction, label in enumerate(('a_to_b', 'b_to_a')):
            initial = flow['syn_seq'][direction]
            initial = (initial + 1) & 0xffffffff if initial is not None else None
            chunks, stats = reassemble(segments[direction], initial)
            final = flow['fin_seq'][direction]
            if final is not None and stats['sequence_origin'] is not None:
                final_relative = ((final - stats['sequence_origin'] + 0x80000000) & 0xffffffff) - 0x80000000
                captured_end = chunks[-1][0] + len(chunks[-1][1]) if chunks else 0
                stats['fin_relative'] = final_relative
                stats['fin_matches_captured_end'] = final_relative == captured_end
                if final_relative > captured_end:
                    stats['gaps'].append({'start_relative': captured_end, 'end_relative': final_relative,
                                          'length': final_relative - captured_end})
            stats['first_payload_frame'] = min((frame for _, frame, _ in segments[direction]), default=None)
            stats['last_payload_frame'] = max((frame for _, frame, _ in segments[direction]), default=None)
            exports = []
            for part, (relative, data) in enumerate(chunks):
                suffix = f'.part{part:03d}' if len(chunks) > 1 else ''
                filename = f'pcap_tcp_{flow["id"]:04d}_{label}{suffix}.bin'
                (out / filename).write_bytes(data)
                application = inspect_application(data)
                if application['protocol'] == 'HTTP':
                    role = 'request' if data.startswith(b'POST ') else 'response'
                    stem = f'pcap_http_{flow["id"]:04d}_{role}{suffix}'
                    application['http'] = inspect_http(data, out, stem)
                exports.append({'file': filename, 'sequence_relative': relative, 'length': len(data),
                                'sample': sample(data), 'application': application})
            stats['chunks'] = exports
            flow['directions'].append(stats)
            protocols = [x['application']['protocol'] for x in exports]
            lines.append(f'  {label}: unique={stats["unique_payload_bytes"]} overlap={stats["overlap_bytes"]} '
                         f'conflicts={stats["conflicting_overlap_bytes"]} gaps={stats["gaps"]} protocols={protocols}')
            for export in exports:
                lines.append(f'    {export["file"]}: {export["sample"]["ascii"]}')
                if export['application']['protocol'] == 'TLS':
                    for hello in export['application']['handshakes']:
                        if 'type' in hello:
                            lines.append('    TLS hello: ' + json.dumps(hello))
        inventory['tcp'].append(flow)
    lines += ['', 'UDP flows:']
    for flow in udp_flows.values():
        datagrams = flow.pop('datagrams')
        filename = f'pcap_udp_{flow["id"]:04d}.bin'
        entries = []
        with (out / filename).open('wb') as handle:
            for frame, timestamp, direction, data in datagrams:
                offset = handle.tell()
                # Record: frame uint32, direction uint8, payload length uint32, payload (network endian).
                handle.write(struct.pack('!IBI', frame, direction, len(data)))
                handle.write(data)
                entry = {'frame': frame, 'timestamp': timestamp, 'direction': direction, 'length': len(data),
                         'container_offset': offset, 'sample': sample(data, 48)}
                if any(endpoint[1] in (53, 5353, 5355) for endpoint in flow['endpoints']):
                    entry['dns'] = inspect_dns(data)
                if any(endpoint[1] in (67, 68) for endpoint in flow['endpoints']):
                    entry['dhcp'] = inspect_dhcp(data)
                entries.append(entry)
        flow['file'] = filename
        flow['container_format'] = 'repeated network-endian uint32 frame, uint8 direction, uint32 payload length, payload'
        flow['datagrams'] = entries
        inventory['udp'].append(flow)
        lines.append(f'UDP {flow["id"]:04d}: {endpoint_text(flow["endpoints"][0])} <-> {endpoint_text(flow["endpoints"][1])} '
                     f'packets={flow["packets"]} bytes={flow["payload_bytes"]} file={filename}')
        for entry in entries[:3]:
            lines.append('  ' + json.dumps(entry.get('dns', entry['sample'])))
    protocol_report = catthief_protocol(inventory, out)
    inventory['protocol_report_file'] = 'pcap_protocol.json' if 'exchanges' in protocol_report else None
    after_hash = hashlib.sha256(capture.read_bytes()).hexdigest()
    metadata['capture_sha256_after'] = after_hash
    metadata['capture_unchanged'] = after_hash == capture_hash
    if not metadata['capture_unchanged']:
        raise ValueError('Capture changed externally during analysis')
    lines += ['', 'Capture unchanged: ' + str(metadata['capture_unchanged']),
              'Protocol report: ' + str(inventory['protocol_report_file'])]
    (out / 'pcap_inventory.json').write_text(json.dumps(inventory, indent=2) + '\n', encoding='utf-8')
    (out / 'pcap_summary.txt').write_text('\n'.join(lines) + '\n', encoding='utf-8')
    print('\n'.join(lines))
    return inventory


def self_test():
    # Entirely in memory: tests create no files and require no capture or network.
    segments = [(103, 2, b'def'), (100, 1, b'abc'), (100, 3, b'abc'), (102, 4, b'cde')]
    chunks, stats = reassemble(segments, 100)
    assert chunks == [(0, b'abcdef')]
    assert stats['overlap_bytes'] == 6 and stats['conflicting_overlap_bytes'] == 0
    chunks, stats = reassemble([(100, 1, b'abc'), (102, 2, b'Xde')], 100)
    assert chunks == [(0, b'abcde')] and stats['conflicting_overlap_bytes'] == 1
    chunks, stats = reassemble([(102, 1, b'abc'), (108, 2, b'de')], 100)
    assert chunks == [(2, b'abc'), (8, b'de')]
    assert [gap['length'] for gap in stats['gaps']] == [2, 3]
    chunks, stats = reassemble([(0xfffffffe, 1, b'ab'), (0, 2, b'cd')], 0xfffffffe)
    assert chunks == [(0, b'abcd')] and not stats['gaps']
    assert reassemble([], 100)[0] == []
    assert dns_name(b'\x03foo\x00\xc0\x00', 5) == ('foo', 7)
    for endian in ('<', '>'):
        def block(kind, body, endian=endian):
            assert len(body) % 4 == 0
            length = len(body) + 12
            return struct.pack(endian + 'II', kind, length) + body + struct.pack(endian + 'I', length)
        shb = block(0x0a0d0d0a, struct.pack(endian + 'IHHq', 0x1a2b3c4d, 1, 0, -1))
        idb = block(1, struct.pack(endian + 'HHI', 1, 0, 65535))
        epb = block(6, struct.pack(endian + 'IIIII', 0, 0, 1000000, 3, 3) + b'abc\x00')
        class MemoryCapture:
            def __init__(self, data):
                self.data = data

            def open(self, mode):
                assert mode == 'rb'
                return io.BytesIO(self.data)
        metadata = {'block_counts': collections.Counter(), 'sections': [], 'interfaces': [],
                    'secrets': [], 'truncated_frames': [], 'packet_comments': []}
        packets = list(pcapng_packets(MemoryCapture(shb + idb + epb), metadata, None))
        assert packets == [(1, 1.0, 1, b'abc')]
        assert metadata['packet_count'] == 1 and metadata['sections'][0]['endian'] == endian
    print('Self-tests passed: out-of-order segments, duplicates, overlaps, conflicts, initial/internal gaps, '
          'sequence wrap, empty streams, DNS compression, little-/big-endian pcapng.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('capture', type=Path, nargs='?')
    parser.add_argument('--self-test', action='store_true')
    args = parser.parse_args()
    if args.self_test:
        self_test()
        return
    if args.capture is None:
        parser.error('capture path is required unless --self-test is used')
    out = Path(__file__).resolve().parent
    if out.name != 'analysis':
        raise SystemExit('Script must live in the analysis directory')
    analyze(args.capture.resolve(), out)


if __name__ == '__main__':
    main()
