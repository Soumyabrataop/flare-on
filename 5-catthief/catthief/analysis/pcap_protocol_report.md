# Offline catthief packet analysis

## Confirmed capture/transport facts
- Capture SHA-256: `bdc90661caa86c1d9ccff8d04b1cef5ac656237813e17091687ebb0fa34decec`.
- 2,810 packets; six TCP connections, three UDP flow pairs. No TLS/SSH handshake or embedded pcapng secrets.
- All six TCP connections go from 192.168.56.103 to 192.168.56.102:8080.
- Every TCP direction has a captured SYN, no sequence gaps, no retransmitted payload bytes, and no conflicting overlaps.
- HTTP/1.1 POST /exfil; User-Agent ureq/2.12.1; all six Content-Length values exactly match capture.
- Responses are HTTP/1.0 200 OK, BaseHTTP/0.6 Python/3.8.10, close-delimited binary bodies.
- Five nonempty responses (36, 37, 40, 36, 40 bytes), followed by one empty response.
- No positively identified public key, master key, nonce, or standard cipher negotiation.

## Filename/keystream inference
- XOR(response body, initial POST body prefix) yields `c:\Us%rs\flare\Desktop\...` for all five responses.
- Assuming normal `Users` spelling corrects byte 5 by XOR 0x40 and gives the paths below.
- Responses appear to select the NEXT upload: the first POST is a 264-byte bootstrap/probe.
- `pcap_response_keystream_prefix.bin` contains 40 inferred XOR pad bytes, NOT a master key.
- `pcap_xor_pad_candidate.bin` extends this to 264 bytes under an unverified zero-filled-bootstrap assumption.
- First 40 pad bytes: `e728a715708a98845da4241e1aa1229f7ab55bb58f39a3a5bf0f1ddfa3ef50110364b78284c2eade`.

| Stream | Client port | Frames | POST body bytes | Probable uploaded file |
|---|---:|---|---:|---|
| 0000 | 49680 | 1-14 | 264 | `(bootstrap/probe)` |
| 0001 | 49681 | 17-626 | 3,121,086 | `important.jpg` |
| 0002 | 49682 | 628-1035 | 2,736,058 | `anothercat.jpg` |
| 0003 | 49683 | 1036-1681 | 3,061,432 | `yetanothercat.jpg` |
| 0004 | 49685 | 1703-2290 | 3,079,606 | `catcatcat.jpg` |
| 0005 | 49686 | 2291-2810 | 2,842,789 | `myfavoritecat.jpg` |

## Empirical request framing and tentative compression clue
- With the candidate XOR pad, `(big_endian_u64(first_8_bytes) >> 21) == POST_body_length - 262` in all six uploads.
- Initial decoded prefix: `00000000004000000000000000000000000000000000000000000000000000000000000000000000`.
- Stream 0001 decoded prefix: `000005f3d700e1010101010101010101010101010101010101010101010101010101010101010101`.
- Shifting the 264-byte probe right by five bits exposes a 256-byte candidate symbol-length table at bytes 6..261.
Candidate lengths predominantly 8, with 7/9/10/11 and one 6. This suggests Huffman-like coding, but candidate Kraft sums are not 1 and the full format is unverified. Do not treat these files as decoded JPEGs.

## UDP/background traffic
- 192.168.56.103:68 <-> 192.168.56.100:67: DHCP REQUEST/ACK (302/548 payload bytes).
- fe80::988a:9121:5600:5fd6:64869 -> ff02::1:3:5355: two LLMNR queries, FLARE-VM, type ANY.
- 192.168.56.103:64869 -> 224.0.0.252:5355: two LLMNR queries, FLARE-VM, type ANY.
- Other packets: IPv6 ICMP, IGMP, and six ARP/non-IP Ethernet frames.

## Outputs
- `pcap_inventory.json`, `pcap_summary.txt`: pcapng metadata, exact endpoints, SYN/FIN state, reassembly accounting, HTTP and UDP metadata, hashes, payload samples.
- `pcap_tcp_0000..0005_{a_to_b,b_to_a}.bin`: twelve raw, contiguous directional TCP streams.
- `pcap_http_0000..0005_{request,response}_body.bin`: HTTP-header-free binary bodies; request 0000 is the bootstrap, requests 0001..0005 are the probable file uploads.
- `pcap_protocol.json`: inference details, candidate file order, per-body SHA-256, framing checks, response hex, code-length histograms.
- `pcap_udp_0000..0002.bin`: lossless datagrams in documented framed containers.

## Concrete next steps
1. In a separate, static-only executable-analysis scope, locate /exfil and ureq call sites; recover request compression/framing and response transform. Do not execute the binary.
2. Validate the candidate XOR pad against known filename responses and the all-six header rule. Determine whether the transform resets a stream generator on every request/response, and recover its actual key/seed or full pad; 40 inferred bytes (264 speculative) cannot decrypt multi-MB uploads.
3. Apply the confirmed transform and codec to the five exported request bodies, in order, starting with stream 0001 (important.jpg). Validate JPEG SOI/EOI and decoded structure before claiming recovery.
