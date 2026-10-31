/*
 * Offline ToxicMiner serial search; canonical algorithm: solve.py.
 * Build: gcc -std=c11 -O3 -march=native -fopenmp solve_serial.c -o solve_serial
 * Library: gcc -std=c11 -O3 -march=native -shared -fPIC -DSOLVER_LIBRARY \
 *              solve_serial.c -o libsolve_serial.so
 * Usage: ./solve_serial [start [end [threads]]]
 * Bounds are inclusive uint32 values (decimal or 0x-prefixed hexadecimal).
 * Defaults: 0 through 0xffffffff, with OpenMP's default thread count.
 * Exit status: 0 = FOUND, 1 = NOT FOUND, 2 = invalid arguments.
 */

#include <stdint.h>
#include <string.h>

#ifndef SOLVER_LIBRARY
#include <errno.h>
#include <inttypes.h>
#include <limits.h>
#include <omp.h>
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#endif

#if defined(__GNUC__) || defined(__clang__)
#define FORCE_INLINE static inline __attribute__((always_inline))
#else
#define FORCE_INLINE static inline
#endif

static const uint32_t IV[8] = {
    0x6a09e667u, 0xbb67ae85u, 0x3c6ef372u, 0xa54ff53au,
    0x510e527fu, 0x9b05688cu, 0x1f83d9abu, 0x5be0cd19u
};

/* All 64 constants are needed by the post-compression byte lookup. */
static const uint32_t K[64] = {
    0x71374491u, 0x428a2f98u, 0xb5c0fbcfu, 0xe9b5dba5u,
    0x3956c25bu, 0x59f111f1u, 0x923f82a4u, 0xab1c5ed5u,
    0xd807aa98u, 0x12835b01u, 0x243185beu, 0x550c7dc3u,
    0x72be5d74u, 0x80deb1feu, 0x9bdc06a7u, 0xc19bf174u,
    0xe49b69c1u, 0xefbe4786u, 0x0fc19dc6u, 0x240ca1ccu,
    0x2de92c6fu, 0x4a7484aau, 0x5cb0a9dcu, 0x76f988dau,
    0x983e5152u, 0xa831c66du, 0xb00327c8u, 0xbf597fc7u,
    0xc6e00bf3u, 0xd5a79147u, 0x06ca6351u, 0x14292967u,
    0x27b70a85u, 0x2e1b2138u, 0x4d2c6dfcu, 0x53380d13u,
    0x650a7354u, 0x766a0abbu, 0x81c2c92eu, 0x92722c85u,
    0xa2bfe8a1u, 0xa81a664bu, 0xc24b8b70u, 0xc76c51a3u,
    0xd192e819u, 0xd6990624u, 0xf40e3585u, 0x106aa070u,
    0x19a4c116u, 0x1e376c08u, 0x2748774cu, 0x34b0bcb5u,
    0x391c0cb3u, 0x4ed8aa4au, 0x5b9cca4fu, 0x682e6ff3u,
    0x748f82eeu, 0x78a5636fu, 0x84c87814u, 0x8cc70208u,
    0x90befffau, 0xa4506cebu, 0xbef9a3f7u, 0xc67178f2u
};

FORCE_INLINE uint32_t ror32(uint32_t value, unsigned count)
{
    return (value >> count) | (value << (32u - count));
}

FORCE_INLINE void store_le32(uint8_t out[4], uint32_t value)
{
    out[0] = (uint8_t)value;
    out[1] = (uint8_t)(value >> 8);
    out[2] = (uint8_t)(value >> 16);
    out[3] = (uint8_t)(value >> 24);
}

FORCE_INLINE uint32_t load_le32(const uint8_t in[4])
{
    return (uint32_t)in[0] | ((uint32_t)in[1] << 8)
         | ((uint32_t)in[2] << 16) | ((uint32_t)in[3] << 24);
}

#define SMALL0(x) (ror32((x), 7) ^ ror32((x), 18) ^ ((x) >> 3))
#define SMALL1(x) (ror32((x), 17) ^ ror32((x), 19) ^ ((x) >> 10))
#define BIG0(x) (ror32((x), 2) ^ ror32((x), 13) ^ ror32((x), 22))
#define BIG1(x) (ror32((x), 6) ^ ror32((x), 11) ^ ror32((x), 25))
#define EXPAND(i) \
    w[(i)] = w[(i) - 16] + SMALL0(w[(i) - 15]) \
           + w[(i) - 7] + SMALL1(w[(i) - 2])

/* Rotating argument names avoids explicit eight-register shifts each round. */
#define ROUND(A, B, C, D, E, F, G, H, i) do { \
    uint32_t t1 = (H) + BIG1(E) + ((((F) + (G)) & (E)) ^ (G)) \
                + K[(i)] + w[(i)]; \
    uint32_t t2 = BIG0(A) + ((((A) & (C)) + ((B) & (C))) ^ ((A) & (B))); \
    (D) += t1; \
    (H) = t1 + t2; \
} while (0)

#define ROUND8(i) do { \
    ROUND(a, b, c, d, e, f, g, h, (i) + 0); \
    ROUND(h, a, b, c, d, e, f, g, (i) + 1); \
    ROUND(g, h, a, b, c, d, e, f, (i) + 2); \
    ROUND(f, g, h, a, b, c, d, e, (i) + 3); \
    ROUND(e, f, g, h, a, b, c, d, (i) + 4); \
    ROUND(d, e, f, g, h, a, b, c, (i) + 5); \
    ROUND(c, d, e, f, g, h, a, b, (i) + 6); \
    ROUND(b, c, d, e, f, g, h, a, (i) + 7); \
} while (0)

FORCE_INLINE void compress(uint32_t state[8], const uint32_t block[16])
{
    uint32_t w[32];
    memcpy(w, block, 16 * sizeof(*w));
    EXPAND(16); EXPAND(17); EXPAND(18); EXPAND(19);
    EXPAND(20); EXPAND(21); EXPAND(22); EXPAND(23);
    EXPAND(24); EXPAND(25); EXPAND(26); EXPAND(27);
    EXPAND(28); EXPAND(29); EXPAND(30); EXPAND(31);

    uint32_t a = state[0], b = state[1], c = state[2], d = state[3];
    uint32_t e = state[4], f = state[5], g = state[6], h = state[7];
    ROUND8(0);
    ROUND8(8);
    ROUND8(16);
    ROUND8(24);

    state[0] += a; state[1] += b; state[2] += c; state[3] += d;
    state[4] += e; state[5] += f; state[6] += g; state[7] += h;

    /* Snapshot BEFORE changing state[0]; the unaligned operand is a DWORD. */
    uint8_t packed[32];
    for (unsigned i = 0; i < 8; ++i)
        store_le32(packed + 4 * i, state[i]);
    unsigned index = state[0] & 255u;
    uint32_t table_byte = (K[index >> 2] >> (8u * (index & 3u))) & 255u;
    state[0] ^= table_byte ^ load_le32(packed + state[1] % 28u);
}

#undef ROUND8
#undef ROUND
#undef EXPAND
#undef BIG1
#undef BIG0
#undef SMALL1
#undef SMALL0

FORCE_INLINE void derive_key_inline(uint32_t serial, uint8_t out[32])
{
    uint32_t first[16] = {
        serial, 0x0b501e7eu, 0x80000000u, [15] = 64u
    };
    uint32_t state[8];
    memcpy(state, IV, sizeof(state));
    compress(state, first);

    uint32_t second[16] = { [8] = 0x80000000u, [15] = 256u };
    memcpy(second, state, sizeof(state));
    memcpy(state, IV, sizeof(state));
    compress(state, second);
    for (unsigned i = 0; i < 8; ++i)
        store_le32(out + 4 * i, state[i]);
}

/* Public ABI for ctypes: output is the full 32-byte little-endian state. */
void derive_key(uint32_t serial, uint8_t out[32])
{
    derive_key_inline(serial, out);
}

#ifndef SOLVER_LIBRARY

enum { PLAINTEXT_LEN = 51, KEY_LEN = 16, WORK_BATCH = 4096 };
#define PROGRESS_CHUNK UINT64_C(16777216)

static const uint8_t CIPHERTEXT[PLAINTEXT_LEN] = {
    0xf4, 0xf9, 0x65, 0x9f, 0x31, 0xf3, 0xda, 0x5c,
    0xf1, 0x37, 0xa1, 0xb8, 0xcf, 0x90, 0xa1, 0x58,
    0x1e, 0xeb, 0xe4, 0x99, 0xa7, 0xc1, 0x1b, 0x15,
    0x02, 0xaf, 0x74, 0x63, 0xd3, 0xb2, 0x19, 0x28,
    0x66, 0xde, 0x3d, 0xe9, 0x71, 0x63, 0xe7, 0x75,
    0xdf, 0xe4, 0xab, 0x61, 0x6f, 0xb9, 0x0c, 0x27,
    0x89, 0xfc, 0x87
};

static const char FLAG_SUFFIX[] = "@flare-on.com";
_Static_assert(sizeof(FLAG_SUFFIX) - 1 == 13, "Suffix includes the @ sign");
_Static_assert(PLAINTEXT_LEN >= sizeof(FLAG_SUFFIX) - 1, "Suffix must fit");

static inline int decrypt_candidate(const uint8_t key[KEY_LEN],
                                    const uint8_t ciphertext[PLAINTEXT_LEN],
                                    char plaintext[PLAINTEXT_LEN + 1])
{
    uint8_t s[256];
    for (unsigned i = 0; i < 256; ++i)
        s[i] = (uint8_t)i;

    unsigned j = 0;
    for (unsigned i = 0; i < 256; ++i) {
        uint8_t si = s[i];
        j = (j + si + key[i & (KEY_LEN - 1)]) & 255u;
        s[i] = s[j];
        s[j] = si;
    }

    j = 0;
    for (unsigned n = 0; n < PLAINTEXT_LEN; ++n) {
        unsigned i = n + 1;
        uint8_t si = s[i];
        j = (j + si) & 255u;
        s[i] = s[j];
        s[j] = si;
        uint8_t byte = ciphertext[n] ^ s[(si + s[i]) & 255u];
        plaintext[n] = (char)byte;
        if (byte < 0x20u || byte > 0x7eu)
            return 0;
        if (n >= PLAINTEXT_LEN - (sizeof(FLAG_SUFFIX) - 1) &&
            byte != (uint8_t)FLAG_SUFFIX[n - (PLAINTEXT_LEN - (sizeof(FLAG_SUFFIX) - 1))])
            return 0;
    }
    /* The binary appends this terminator; it is not ciphertext byte 52. */
    plaintext[PLAINTEXT_LEN] = '\0';
    return 1;
}

static void usage(const char *program)
{
    fprintf(stderr,
            "Usage: %s [start [end [threads]]]\n"
            "  Inclusive uint32 bounds: decimal or 0x-prefixed hexadecimal.\n"
            "  Defaults: start=0, end=0xffffffff, threads=OpenMP default.\n"
            "  Exit status: 0=FOUND, 1=NOT FOUND, 2=invalid arguments.\n",
            program);
}

static int parse_number(const char *text, uint64_t maximum, uint64_t *out)
{
    if (text[0] < '0' || text[0] > '9')
        return 0;
    int base = text[0] == '0' && (text[1] == 'x' || text[1] == 'X') ? 16 : 10;
    errno = 0;
    char *end;
    unsigned long long value = strtoull(text, &end, base);
    if (errno != 0 || end == text || *end != '\0' || value > maximum)
        return 0;
    *out = (uint64_t)value;
    return 1;
}

int main(int argc, char **argv)
{
    uint64_t start = 0, end = UINT32_MAX;
    uint64_t threads = (uint64_t)omp_get_max_threads();
    if (argc > 4 ||
        (argc > 1 && !parse_number(argv[1], UINT32_MAX, &start)) ||
        (argc > 2 && !parse_number(argv[2], UINT32_MAX, &end)) ||
        (argc > 3 && (!parse_number(argv[3], INT_MAX, &threads) || threads == 0)) ||
        start > end) {
        usage(argv[0]);
        return 2;
    }
    omp_set_dynamic(0);
    omp_set_num_threads((int)threads);

    /* A 64-bit exclusive limit prevents wrapping after serial 0xffffffff. */
    const uint64_t limit = end + 1;
    const uint64_t total = limit - start;
    uint64_t checked = 0;
    atomic_int found = ATOMIC_VAR_INIT(0);
    uint32_t winning_serial = 0;
    uint8_t winning_key[KEY_LEN];
    char winning_plaintext[PLAINTEXT_LEN + 1];
    double began = omp_get_wtime();

    fprintf(stderr, "Range: 0x%08" PRIx64 "..0x%08" PRIx64
            " (inclusive), threads=%" PRIu64 ", candidates=%" PRIu64 "\n",
            start, end, threads, total);

    for (uint64_t chunk_start = start; chunk_start < limit;) {
        uint64_t chunk_end = chunk_start + PROGRESS_CHUNK;
        if (chunk_end > limit)
            chunk_end = limit;
        uint64_t chunk_checked = 0;

        #pragma omp parallel for schedule(dynamic, 1) reduction(+:chunk_checked)
        for (uint64_t batch = chunk_start; batch < chunk_end; batch += WORK_BATCH) {
            if (atomic_load_explicit(&found, memory_order_relaxed))
                continue;
            uint64_t batch_end = batch + WORK_BATCH;
            if (batch_end > chunk_end)
                batch_end = chunk_end;
            uint8_t key[32];
            char plaintext[PLAINTEXT_LEN + 1];
            for (uint64_t value = batch; value < batch_end; ++value) {
                if (atomic_load_explicit(&found, memory_order_relaxed))
                    break;
                derive_key_inline((uint32_t)value, key);
                ++chunk_checked;
                if (!decrypt_candidate(key, CIPHERTEXT, plaintext))
                    continue;
                int expected = 0;
                if (atomic_compare_exchange_strong_explicit(&found, &expected, 1,
                        memory_order_relaxed, memory_order_relaxed)) {
                    winning_serial = (uint32_t)value;
                    memcpy(winning_key, key, sizeof(winning_key));
                    memcpy(winning_plaintext, plaintext, sizeof(winning_plaintext));
                }
                break;
            }
        }
        /* The implicit parallel-region barrier publishes the winner's data. */
        checked += chunk_checked;
        double elapsed = omp_get_wtime() - began;
        double rate = elapsed > 0.0 ? (double)checked / elapsed : 0.0;
        fprintf(stderr, "Progress: %" PRIu64 "/%" PRIu64 " (%.2f%%), "
                "%.3f Mserial/s, %.2f s elapsed\n",
                checked, total, 100.0 * (double)checked / (double)total,
                rate / 1e6, elapsed);

        if (atomic_load_explicit(&found, memory_order_relaxed)) {
            printf("FOUND serial=0x%08" PRIx32 " (%" PRIu32 ")\n",
                   winning_serial, winning_serial);
            printf("RC4 key: ");
            for (unsigned i = 0; i < KEY_LEN; ++i)
                printf("%02x", (unsigned)winning_key[i]);
            printf("\nFlag: %s\n", winning_plaintext);
            return 0;
        }
        chunk_start = chunk_end;
    }

    printf("NOT FOUND in [0x%08" PRIx64 ", 0x%08" PRIx64 "]\n", start, end);
    return 1;
}

#endif /* !SOLVER_LIBRARY */
