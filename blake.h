// Gateless Gate, a Zcash miner
// Copyright 2016 zawawa @ bitcointalk.org
//
// The initial version of this software was based on:
// SILENTARMY v5
// Copyright 2016 Marc Bevand, Genoil
//
// This program is free software : you can redistribute it and / or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.If not, see <http://www.gnu.org/licenses/>.

typedef struct  blake2b_state_s
{
    uint64_t    h[8];
    uint64_t    bytes;
}               blake2b_state_t;
void zcash_blake2b_init(blake2b_state_t *st, uint8_t hash_len,
	uint32_t n, uint32_t k);
void zcash_blake2b_update(blake2b_state_t *st, const uint8_t *_msg,
        uint32_t msg_len, uint32_t is_final);
void zcash_blake2b_final(blake2b_state_t *st, uint8_t *out, uint8_t outlen);
