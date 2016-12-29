// Gateless Gate, a Zcash miner
// Copyright 2016 zawawa @ bitcointalk.org
//
// The initial version of this software was based on:
// SILENTARMY v5
// The MIT License (MIT) Copyright (c) 2016 Marc Bevand, Genoil
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
// along with this program. If not, see <http://www.gnu.org/licenses/>.

#ifndef PARAM_H
#include "param.h"
#endif

#pragma OPENCL EXTENSION cl_khr_global_int32_base_atomics : enable
#ifdef AMD
#pragma OPENCL EXTENSION cl_amd_vec3 : enable
#endif



/////////////////
// HASH TABLES //
/////////////////

/*
** With the new hash tables, each slot has this layout (length in bytes in parens):
**
** round 0, table 0: i(4) pad(0) Xi(24) pad(4)
** round 1, table 1: i(4) pad(3) Xi(20) pad(5)
** round 2, table 2: i(4) pad(0) Xi(19) pad(9)
** round 3, table 3: i(4) pad(3) Xi(15) pad(10)
** round 4, table 4: i(4) pad(0) Xi(14) pad(14)
** round 5, table 5: i(4) pad(3) Xi(10) pad(15)
** round 6, table 6: i(4) pad(0) Xi( 9) pad(19)
** round 7, table 7: i(4) pad(3) Xi( 5) pad(20)
** round 8, table 8: i(4) pad(0) Xi( 4) pad(24)
*/

typedef union {
	struct {
		uint xi[7];
		uint padding;
	} slot;
	uint8 ui8;
	uint4 ui4[2];
	uint2 ui2[4];
	uint  ui[8];
#ifdef AMD
	uint3 ui3[2];
	ulong3 ul3;
#endif
} slot_t;

typedef __global slot_t *global_pointer_to_slot_t;


#define UINTS_IN_XI(round) (((round) == 0) ? 6 : \
                            ((round) == 1) ? 6 : \
                            ((round) == 2) ? 5 : \
                            ((round) == 3) ? 5 : \
                            ((round) == 4) ? 4 : \
                            ((round) == 5) ? 4 : \
                            ((round) == 6) ? 3 : \
                            ((round) == 7) ? 2 : \
                                             1)

#if MAX_NR_SLOTS < 255
#define SLOT_INDEX_TYPE uchar
#elif MAX_NR_SLOTS < 65535
#define SLOT_INDEX_TYPE ushort
#else
#error "unsupported MAX_NR_SLOTS"
#endif



/*
** Reset counters in a hash table.
*/

__kernel
void kernel_init_ht(__global char *ht, __global uint *rowCounters)
{
	if (get_global_id(0) < ROW_COUNTERS_SIZE / 4)
		rowCounters[get_global_id(0)] = 0;
}

/*
** OBSOLETE
** If xi0,xi1,xi2,xi3 are stored consecutively in little endian then they
** represent (hex notation, group of 5 hex digits are a group of PREFIX bits):
**   aa aa ab bb bb cc cc cd dd...  [round 0]
**         --------------------
**      ...ab bb bb cc cc cd dd...  [odd round]
**               --------------
**               ...cc cc cd dd...  [next even round]
**                        -----
** Bytes underlined are going to be stored in the slot. Preceding bytes
** (and possibly part of the underlined bytes, depending on NR_ROWS_LOG) are
** used to compute the row number.
**
** Round 0: xi0,xi1,xi2,xi3 is a 25-byte Xi (xi3: only the low byte matter)
** Round 1: xi0,xi1,xi2 is a 23-byte Xi (incl. the colliding PREFIX nibble)
** TODO: update lines below with padding nibbles
** Round 2: xi0,xi1,xi2 is a 20-byte Xi (xi2: only the low 4 bytes matter)
** Round 3: xi0,xi1,xi2 is a 17.5-byte Xi (xi2: only the low 1.5 bytes matter)
** Round 4: xi0,xi1 is a 15-byte Xi (xi1: only the low 7 bytes matter)
** Round 5: xi0,xi1 is a 12.5-byte Xi (xi1: only the low 4.5 bytes matter)
** Round 6: xi0,xi1 is a 10-byte Xi (xi1: only the low 2 bytes matter)
** Round 7: xi0 is a 7.5-byte Xi (xi0: only the low 7.5 bytes matter)
** Round 8: xi0 is a 5-byte Xi (xi0: only the low 5 bytes matter)
**
** Return 0 if successfully stored, or 1 if the row overflowed.
*/

__global char *get_slot_ptr(__global char *ht, uint round, uint row, uint slot)
{
	return ht + (row * NR_SLOTS(round) + slot) * SLOT_LEN(round);
}

__global uint *get_xi_ptr(__global char *ht, uint round, uint row, uint slot)
{
	return (__global uint *)get_slot_ptr(ht, round, row, slot);
}

__global uint *get_ref_ptr(__global char *ht, uint round, uint row, uint slot)
{
	return get_xi_ptr(ht, round, row, slot) + UINTS_IN_XI(round);
}

void get_row_counters_index(uint round, uint *rowIdx, uint *rowOffset, uint row)
{
	if (ROWS_PER_UINT(round) == 3) {
		uint r = (0x55555555 * row + (row >> 1) - (row >> 3)) >> 30;
		*rowIdx = (row - r) * 0xAAAAAAAB;
		*rowOffset = BITS_PER_ROW(round) * r;
	} else if (ROWS_PER_UINT(round) == 6) {
		uint r = (0x55555555 * row + (row >> 1) - (row >> 3)) >> 29;
		*rowIdx = (row - r) * 0xAAAAAAAB * 2;
		*rowOffset = BITS_PER_ROW(round) * r;
	} else {
		*rowIdx = row / ROWS_PER_UINT(round);
		*rowOffset = BITS_PER_ROW(round) * (row % ROWS_PER_UINT(round));
	}
}

uint get_row(uint round, uint xi0)
{
	uint           row = 0;

	if (NR_ROWS_LOG(round) == 12) {
		if (!(round % 2))
			row = (xi0 & 0xfff);
		else
			row = ((xi0 & 0x0f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
	} else if (NR_ROWS_LOG(round) == 13) {
		if (!(round % 2))
			row = (xi0 & 0x1fff);
		else
			row = ((xi0 & 0x1f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
	} else if (NR_ROWS_LOG(round) == 14) {
		if (!(round % 2))
			row = (xi0 & 0x3fff);
		else
			row = ((xi0 & 0x3f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
	} else if (NR_ROWS_LOG(round) == 15) {
		if (!(round % 2))
			row = (xi0 & 0x7fff);
		else
			row = ((xi0 & 0x7f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
	} else if (NR_ROWS_LOG(round) == 16) {
		if (!(round % 2))
			row = (xi0 & 0xffff);
		else
			row = ((xi0 & 0xff0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
	}

	return row;
}

uint inc_row_counter(uint round, __global uint *rowCounters, uint row)
{
	uint rowIdx, rowOffset;
	get_row_counters_index(round, &rowIdx, &rowOffset, row);
	uint nr_slots = atom_add(rowCounters + rowIdx, 1 << rowOffset);
	nr_slots = (nr_slots >> rowOffset) & ROW_MASK(round);
	if (nr_slots >= NR_SLOTS(round)) {
		// avoid overflows
		atom_sub(rowCounters + rowIdx, 1 << rowOffset);
	}
	return nr_slots;
}



/////////////
// ROUND 1 //
/////////////

__constant ulong blake_iv[] =
{
	0x6a09e667f3bcc908, 0xbb67ae8584caa73b,
	0x3c6ef372fe94f82b, 0xa54ff53a5f1d36f1,
	0x510e527fade682d1, 0x9b05688c2b3e6c1f,
	0x1f83d9abfb41bd6b, 0x5be0cd19137e2179,
};

#define mix(va, vb, vc, vd, x, y) \
    va = (va + vb + (x)); \
vd = rotate((vd ^ va), (ulong)64 - 32); \
vc = (vc + vd); \
vb = rotate((vb ^ vc), (ulong)64 - 24); \
va = (va + vb + (y)); \
vd = rotate((vd ^ va), (ulong)64 - 16); \
vc = (vc + vd); \
vb = rotate((vb ^ vc), (ulong)64 - 63);

/*
** Execute round 0 (blake).
**
** Note: making the work group size less than or equal to the wavefront size
** allows the OpenCL compiler to remove the barrier() calls, see "2.2 Local
** Memory (LDS) Optimization 2-10" in:
** http://developer.amd.com/tools-and-sdks/opencl-zone/amd-accelerated-parallel-processing-app-sdk/opencl-optimization-guide/
*/

#if ZCASH_HASH_LEN != 50
#error "unsupported ZCASH_HASH_LEN"
#endif

__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE_ROUND0, 1, 1)))
void kernel_round0(__constant ulong *blake_state, __global char *ht,
				   __global uint *rowCounters, __global uint *debug)
{
	uint                tid = get_global_id(0);
#ifdef AMD
	volatile ulong      v[16];
	volatile uint xi0, xi1, xi2, xi3, xi4, xi5, xi6;
    slot_t slot;
#else
	ulong               v[16];
	uint xi0, xi1, xi2, xi3, xi4, xi5, xi6;
	slot_t slot;
#endif
	ulong               h[7];
	uint                inputs_per_thread = (NR_INPUTS + get_global_size(0) - 1) / get_global_size(0);
	uint                dropped = 0;
	
	for (uint chunk = 0; chunk < inputs_per_thread; ++chunk) {
		uint input = tid + get_global_size(0) * chunk;
		
		if (input < NR_INPUTS) {
			// shift "i" to occupy the high 32 bits of the second ulong word in the
			// message block
			ulong word1 = (ulong)input << 32;
			// init vector v
			v[0] = blake_state[0];
			v[1] = blake_state[1];
			v[2] = blake_state[2];
			v[3] = blake_state[3];
			v[4] = blake_state[4];
			v[5] = blake_state[5];
			v[6] = blake_state[6];
			v[7] = blake_state[7];
			v[8] = blake_iv[0];
			v[9] = blake_iv[1];
			v[10] = blake_iv[2];
			v[11] = blake_iv[3];
			v[12] = blake_iv[4];
			v[13] = blake_iv[5];
			v[14] = blake_iv[6];
			v[15] = blake_iv[7];
			// mix in length of data
			v[12] ^= ZCASH_BLOCK_HEADER_LEN + 4 /* length of "i" */;
			// last block
			v[14] ^= (ulong)-1;

#ifdef AMD
#pragma unroll 1
			for (uint blake_round = 1; blake_round <= 9; ++blake_round) {
#else
#pragma unroll 9
			for (uint blake_round = 1; blake_round <= 9; ++blake_round) {
#endif
				mix(v[0], v[4], v[8],  v[12], 0, (blake_round == 1) ? word1 : 0);
				mix(v[1], v[5], v[9],  v[13], (blake_round == 7) ? word1 : 0, (blake_round == 4) ? word1 : 0);
				mix(v[2], v[6], v[10], v[14], 0, (blake_round == 8) ? word1 : 0);
				mix(v[3], v[7], v[11], v[15], 0, 0);
				mix(v[0], v[5], v[10], v[15], (blake_round == 2) ? word1 : 0, (blake_round == 5) ? word1 : 0);
				mix(v[1], v[6], v[11], v[12], 0, 0);
				mix(v[2], v[7], v[8],  v[13], (blake_round == 9) ? word1 : 0, (blake_round == 3) ? word1 : 0);
				mix(v[3], v[4], v[9],  v[14], (blake_round == 6) ? word1 : 0, 0);
			}
			// round 10
			mix(v[0], v[4], v[8], v[12], 0, 0);
			mix(v[1], v[5], v[9], v[13], 0, 0);
			mix(v[2], v[6], v[10], v[14], 0, 0);
			mix(v[3], v[7], v[11], v[15], word1, 0);
			mix(v[0], v[5], v[10], v[15], 0, 0);
			mix(v[1], v[6], v[11], v[12], 0, 0);
			mix(v[2], v[7], v[8], v[13], 0, 0);
			mix(v[3], v[4], v[9], v[14], 0, 0);
			// round 11
			mix(v[0], v[4], v[8], v[12], 0, word1);
			mix(v[1], v[5], v[9], v[13], 0, 0);
			mix(v[2], v[6], v[10], v[14], 0, 0);
			mix(v[3], v[7], v[11], v[15], 0, 0);
			mix(v[0], v[5], v[10], v[15], 0, 0);
			mix(v[1], v[6], v[11], v[12], 0, 0);
			mix(v[2], v[7], v[8], v[13], 0, 0);
			mix(v[3], v[4], v[9], v[14], 0, 0);
			// round 12
			mix(v[0], v[4], v[8], v[12], 0, 0);
			mix(v[1], v[5], v[9], v[13], 0, 0);
			mix(v[2], v[6], v[10], v[14], 0, 0);
			mix(v[3], v[7], v[11], v[15], 0, 0);
			mix(v[0], v[5], v[10], v[15], word1, 0);
			mix(v[1], v[6], v[11], v[12], 0, 0);
			mix(v[2], v[7], v[8], v[13], 0, 0);
			mix(v[3], v[4], v[9], v[14], 0, 0);

			// compress v into the blake state; this produces the 50-byte hash
			// (two Xi values)
			h[0] = blake_state[0] ^ v[0] ^ v[8];
			h[1] = blake_state[1] ^ v[1] ^ v[9];
			h[2] = blake_state[2] ^ v[2] ^ v[10];
			h[3] = blake_state[3] ^ v[3] ^ v[11];
			h[4] = blake_state[4] ^ v[4] ^ v[12];
			h[5] = blake_state[5] ^ v[5] ^ v[13];
			h[6] = (blake_state[6] ^ v[6] ^ v[14]) & 0xffff;
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		if (input < NR_INPUTS && THREADS_PER_WRITE(0) == 1) {
			// store the two Xi values in the hash table
#pragma unroll 1
			for (uint index = 0; index < 2; ++index) {
				if (!index) {
					xi0 = h[0] & 0xffffffff; xi1 = h[0] >> 32;
					xi2 = h[1] & 0xffffffff; xi3 = h[1] >> 32;
					xi4 = h[2] & 0xffffffff; xi5 = h[2] >> 32;
					xi6 = h[3] & 0xffffffff;
				} else {
					xi0 = ((h[3] >> 8) | (h[4] << (64 - 8))) & 0xffffffff; xi1 = ((h[3] >> 8) | (h[4] << (64 - 8))) >> 32;
					xi2 = ((h[4] >> 8) | (h[5] << (64 - 8))) & 0xffffffff; xi3 = ((h[4] >> 8) | (h[5] << (64 - 8))) >> 32;
					xi4 = ((h[5] >> 8) | (h[6] << (64 - 8))) & 0xffffffff; xi5 = ((h[5] >> 8) | (h[6] << (64 - 8))) >> 32;
					xi6 = (h[6] >> 8) & 0xffffffff;
				}

				uint row = get_row(0, xi0);
				uint nr_slots = inc_row_counter(0, rowCounters, row);
				if (nr_slots >= NR_SLOTS(0)) {
					++dropped;
				} else {
					slot.slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
					slot.slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
					slot.slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
					slot.slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
					slot.slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
					slot.slot.xi[5] = ((xi6 << 24) | (xi5 >> 8));
					slot.slot.xi[UINTS_IN_XI(0)] = input * 2 + index;
					__global char *p = get_slot_ptr(ht, 0, row, nr_slots);
					*(__global uint8 *)p = slot.ui8;
				}
			}
		} else if (THREADS_PER_WRITE(0) > 1) {
			__local slot_t slot_array[LOCAL_WORK_SIZE_ROUND0];
			__local global_pointer_to_slot_t slot_ptrs[LOCAL_WORK_SIZE_ROUND0];
			
			slot_ptrs[get_local_id(0)] = (__global slot_t *)get_slot_ptr(ht, 0, NR_ROWS(0) - 1, NR_SLOTS(0) - 1);
			
			barrier(CLK_LOCAL_MEM_FENCE);

			if (input < NR_INPUTS) {
				// store the two Xi values in the hash table
				xi0 = h[0] & 0xffffffff; xi1 = h[0] >> 32;
				xi2 = h[1] & 0xffffffff; xi3 = h[1] >> 32;
				xi4 = h[2] & 0xffffffff; xi5 = h[2] >> 32;
				xi6 = h[3] & 0xffffffff;

				uint row = get_row(0, xi0);
				uint nr_slots = inc_row_counter(0, rowCounters, row);
				if (nr_slots >= NR_SLOTS(0)) {
					++dropped;
				} else {
					slot_array[get_local_id(0)].slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
					slot_array[get_local_id(0)].slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
					slot_array[get_local_id(0)].slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
					slot_array[get_local_id(0)].slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
					slot_array[get_local_id(0)].slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
					slot_array[get_local_id(0)].slot.xi[5] = ((xi6 << 24) | (xi5 >> 8));
					slot_array[get_local_id(0)].slot.xi[UINTS_IN_XI(0)] = input * 2;
					slot_ptrs[get_local_id(0)] = (__global slot_t *)get_slot_ptr(ht, 0, row, nr_slots);
				}
			}

			barrier(CLK_LOCAL_MEM_FENCE);

			uint write_thread_index = get_local_id(0) % THREADS_PER_WRITE(0);
			uint local_id_base = get_local_id(0) - write_thread_index;

			for (uint write_index = 0; write_index < THREADS_PER_WRITE(0); ++write_index)
				if (THREADS_PER_WRITE(0) == 2)
					*((__global uint4 *)slot_ptrs[local_id_base + write_index] + write_thread_index)
					= slot_array[local_id_base + write_index].ui4[write_thread_index];

			barrier(CLK_LOCAL_MEM_FENCE);

			slot_ptrs[get_local_id(0)] = (__global slot_t *)get_slot_ptr(ht, 0, NR_ROWS(0) - 1, NR_SLOTS(0) - 1);

			barrier(CLK_LOCAL_MEM_FENCE);

			if (input < NR_INPUTS) {
				xi0 = ((h[3] >> 8) | (h[4] << (64 - 8))) & 0xffffffff; xi1 = ((h[3] >> 8) | (h[4] << (64 - 8))) >> 32;
				xi2 = ((h[4] >> 8) | (h[5] << (64 - 8))) & 0xffffffff; xi3 = ((h[4] >> 8) | (h[5] << (64 - 8))) >> 32;
				xi4 = ((h[5] >> 8) | (h[6] << (64 - 8))) & 0xffffffff; xi5 = ((h[5] >> 8) | (h[6] << (64 - 8))) >> 32;
				xi6 = (h[6] >> 8) & 0xffffffff;

				uint row = get_row(0, xi0);
				uint nr_slots = inc_row_counter(0, rowCounters, row);
				if (nr_slots >= NR_SLOTS(0)) {
					++dropped;
				} else {
					slot_array[get_local_id(0)].slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
					slot_array[get_local_id(0)].slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
					slot_array[get_local_id(0)].slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
					slot_array[get_local_id(0)].slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
					slot_array[get_local_id(0)].slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
					slot_array[get_local_id(0)].slot.xi[5] = ((xi6 << 24) | (xi5 >> 8));
					slot_array[get_local_id(0)].slot.xi[UINTS_IN_XI(0)] = input * 2 + 1;
					slot_ptrs[get_local_id(0)] = (__global slot_t *)get_slot_ptr(ht, 0, row, nr_slots);
				}
			}

			barrier(CLK_LOCAL_MEM_FENCE);

			for (uint write_index = 0; write_index < THREADS_PER_WRITE(0); ++write_index)
				if (THREADS_PER_WRITE(0) == 2)
					*((__global uint4 *)slot_ptrs[local_id_base + write_index] + write_thread_index)
						= slot_array[local_id_base + write_index].ui4[write_thread_index];

			barrier(CLK_LOCAL_MEM_FENCE);
		}

		barrier(CLK_LOCAL_MEM_FENCE);
	}
#ifdef ENABLE_DEBUG
	debug[tid * 2] = 0;
	debug[tid * 2 + 1] = dropped;
#endif
}

/*
** XOR a pair of Xi values computed at "round - 1" and store the result in the
** hash table being built for "round". Note that when building the table for
** even rounds we need to skip 1 padding byte present in the "round - 1" table
** (the "0xAB" byte mentioned in the description at the top of this file.) But
** also note we can't load data directly past this byte because this would
** cause an unaligned memory access which is undefined per the OpenCL spec.
**
** Return 0 if successfully stored, or 1 if the row overflowed.
*/

uint xor_and_store(uint round, __global char *ht_src, __global char *ht_dst, uint row,
	uint slot_a, uint slot_b, __local uint *ai, __local uint *bi,
	__global uint *rowCounters) {
	uint ret = 0;
	uint xi0, xi1, xi2, xi3, xi4, xi5;
	uint write_index = get_local_id(0) / THREADS_PER_WRITE(round);
	uint write_thread_index = get_local_id(0) % THREADS_PER_WRITE(round);
	//uint write_index = get_local_id(0) % (get_local_size(0) / THREADS_PER_WRITE(round));
	//uint write_thread_index = get_local_id(0) / (get_local_size(0) / THREADS_PER_WRITE(round));

#if NR_ROWS_LOG < 8 && NR_ROWS_LOG > 20
#error "unsupported NR_ROWS_LOG"
#endif

	slot_t slot;
	__global slot_t *p = 0;

	if (slot_a < NR_SLOTS(round - 1) && slot_b < NR_SLOTS(round - 1)) {
#ifdef OPTIM_SHRINKED_SLOT_CACHE
		if (slot_a < SLOT_CACHE_SIZE(round - 1)) {
#endif
			xi0 = *ai;
			xi1 = *(ai += SLOT_CACHE_SIZE(round - 1));
			if (round <= 7) xi2 = *(ai += SLOT_CACHE_SIZE(round - 1));
			if (round <= 6) xi3 = *(ai += SLOT_CACHE_SIZE(round - 1));
			if (round <= 4) xi4 = *(ai += SLOT_CACHE_SIZE(round - 1));
			if (round <= 2) xi5 = *(ai += SLOT_CACHE_SIZE(round - 1));
#ifdef OPTIM_SHRINKED_SLOT_CACHE
		} else {
			xi0 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 0);
			xi1 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 1);
			if (round <= 7) xi2 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 2);
			if (round <= 6) xi3 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 3);
			if (round <= 4) xi4 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 4);
			if (round <= 2) xi5 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 5);
		}
#endif

#ifdef OPTIM_SHRINKED_SLOT_CACHE
		if (slot_b < SLOT_CACHE_SIZE(round - 1)) {
#endif
			xi0 ^= *bi;
			xi1 ^= *(bi += SLOT_CACHE_SIZE(round - 1));
			if (round <= 7) xi2 ^= *(bi += SLOT_CACHE_SIZE(round - 1));
			if (round <= 6) xi3 ^= *(bi += SLOT_CACHE_SIZE(round - 1));
			if (round <= 4) xi4 ^= *(bi += SLOT_CACHE_SIZE(round - 1));
			if (round <= 2) xi5 ^= *(bi += SLOT_CACHE_SIZE(round - 1));
#ifdef OPTIM_SHRINKED_SLOT_CACHE
		} else {
			xi0 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 0);
			xi1 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 1);
			if (round <= 7) xi2 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 2);
			if (round <= 6) xi3 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 3);
			if (round <= 4) xi4 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 4);
			if (round <= 2) xi5 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 5);
		}
#endif

		if (!(round & 0x1)) {
			// skip padding bytes
			xi0 = (xi0 >> 24) | (xi1 << (32 - 24));

			slot.slot.xi[0] = xi1;
			slot.slot.xi[1] = xi2;
			slot.slot.xi[2] = xi3;
			slot.slot.xi[3] = xi4;
			slot.slot.xi[4] = xi5;
		} else {
			slot.slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
			if (round <= 7) slot.slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
			if (round <= 6) slot.slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
			if (round <= 5) slot.slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
			if (round <= 3) slot.slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
			if (round <= 1) slot.slot.xi[5] = ((xi5 >> 8));
		}
		slot.slot.xi[UINTS_IN_XI(round)] = ENCODE_INPUTS(round - 1, row, slot_a, slot_b);

		// invalid solutions (which start happenning in round 5) have duplicate
		// inputs and xor to zero, so discard them
		if (xi0 || xi1) {
			uint new_row = get_row(round, xi0);
			uint new_slot_index = inc_row_counter(round, rowCounters, new_row);
			if (new_slot_index >= NR_SLOTS(round)) {
				ret = 1;
			}
			else {
				p = (__global slot_t *)get_slot_ptr(ht_dst, round, new_row, new_slot_index);
			}
		}
	}

	if (p) {
#ifdef OPTIM_8BYTE_WRITES
		if (round >= 8)
			*(__global uint2 *)p = slot.ui2[0];
		else
#endif
#ifdef OPTIM_12BYTE_WRITES
		if (round >= 7)
			*(__global uint3 *)p = slot.ui3[0];
		else
#endif
#ifdef OPTIM_16BYTE_WRITES
		if (round >= 6)
			*(__global uint4 *)p = slot.ui4[0];
		else
#endif
#ifdef OPTIM_24BYTE_WRITES
		if (round >= 2)
			*(__global ulong3 *)p = slot.ul3;
		else
#endif
			*(__global uint8 *)p = slot.ui8;
	}
	return ret;
}

uint parallel_xor_and_store(uint round, __global char *ht_src, __global char *ht_dst, uint row,
	uint slot_a, uint slot_b, __local uint *ai, __local uint *bi,
	__global uint *rowCounters,
	__local SLOT_INDEX_TYPE *new_slot_indexes) {
	uint ret = 0;
	uint xi0, xi1, xi2, xi3, xi4, xi5;
	uint write_index = get_local_id(0) / THREADS_PER_WRITE(round);
	uint write_thread_index = get_local_id(0) % THREADS_PER_WRITE(round);
	//uint write_index = get_local_id(0) % (get_local_size(0) / THREADS_PER_WRITE(round));
	//uint write_thread_index = get_local_id(0) / (get_local_size(0) / THREADS_PER_WRITE(round));

#if NR_ROWS_LOG < 8 && NR_ROWS_LOG > 20
#error "unsupported NR_ROWS_LOG"
#endif

	slot_t slot;
	uint new_slot_index;
	uint new_row;

	if (!write_thread_index)
		new_slot_indexes[write_index] = NR_SLOTS(round);
	barrier(CLK_LOCAL_MEM_FENCE);

	if (slot_a < NR_SLOTS(round - 1) && slot_b < NR_SLOTS(round - 1)) {
#ifdef OPTIM_SHRINKED_SLOT_CACHE
		if (slot_a < SLOT_CACHE_SIZE(round - 1)) {
#endif
			xi0 = *ai;
			xi1 = *(ai += NR_SLOTS(round - 1));
			if (round <= 7) xi2 = *(ai += NR_SLOTS(round - 1));
			if (round <= 6) xi3 = *(ai += NR_SLOTS(round - 1));
			if (round <= 4) xi4 = *(ai += NR_SLOTS(round - 1));
			if (round <= 2) xi5 = *(ai += NR_SLOTS(round - 1));
#ifdef OPTIM_SHRINKED_SLOT_CACHE
		} else {
			xi0 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 0);
			xi1 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 1);
			if (round <= 7) xi2 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 2);
			if (round <= 6) xi3 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 3);
			if (round <= 4) xi4 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 4);
			if (round <= 2) xi5 = *(get_xi_ptr(ht_src, round - 1, row, slot_a) + 5);
		}
#endif

#ifdef OPTIM_SHRINKED_SLOT_CACHE
		if (slot_b < SLOT_CACHE_SIZE(round - 1)) {
#endif
			xi0 ^= *bi;
			xi1 ^= *(bi += NR_SLOTS(round - 1));
			if (round <= 7) xi2 ^= *(bi += NR_SLOTS(round - 1));
			if (round <= 6) xi3 ^= *(bi += NR_SLOTS(round - 1));
			if (round <= 4) xi4 ^= *(bi += NR_SLOTS(round - 1));
			if (round <= 2) xi5 ^= *(bi += NR_SLOTS(round - 1));
#ifdef OPTIM_SHRINKED_SLOT_CACHE
		} else {
			xi0 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 0);
			xi1 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 1);
			if (round <= 7) xi2 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 2);
			if (round <= 6) xi3 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 3);
			if (round <= 4) xi4 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 4);
			if (round <= 2) xi5 = *(get_xi_ptr(ht_src, round - 1, row, slot_b) + 5);
		}
#endif

		if (!(round & 0x1)) {
			// skip padding bytes
			xi0 = (xi0 >> 24) | (xi1 << (32 - 24));

			slot.slot.xi[0] = xi1;
			slot.slot.xi[1] = xi2;
			slot.slot.xi[2] = xi3;
			slot.slot.xi[3] = xi4;
			slot.slot.xi[4] = xi5;
		} else {
			slot.slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
			slot.slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
			slot.slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
			slot.slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
			slot.slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
			slot.slot.xi[5] = ((xi5 >> 8));
		}
		slot.slot.xi[UINTS_IN_XI(round)] = ENCODE_INPUTS(round - 1, row, slot_a, slot_b);
		new_row = get_row(round, xi0);

		// invalid solutions (which start happenning in round 5) have duplicate
		// inputs and xor to zero, so discard them
		if ((xi0 || xi1) && !write_thread_index) {
			new_slot_index = inc_row_counter(round, rowCounters, new_row);
			if (new_slot_index >= NR_SLOTS(round))
				ret = 1;
			new_slot_indexes[write_index] = new_slot_index;
		}
	}

	barrier(CLK_LOCAL_MEM_FENCE);
	if (write_thread_index)
		new_slot_index = new_slot_indexes[write_index];
	barrier(CLK_LOCAL_MEM_FENCE);
	if (THREADS_PER_WRITE(round) == 2 && new_slot_index < NR_SLOTS(round)) {
		__global slot_t *p = (__global slot_t *)get_slot_ptr(ht_dst, round, new_row, new_slot_index);
		*(((__global uint4 *)p) + write_thread_index) = slot.ui4[write_thread_index];
	} else if (THREADS_PER_WRITE(round) == 4 && new_slot_index < NR_SLOTS(round)) {
		__global slot_t *p = (__global slot_t *)get_slot_ptr(ht_dst, round, new_row, new_slot_index);
		*(((__global uint2 *)p) + write_thread_index) = slot.ui2[write_thread_index];
	} else if (THREADS_PER_WRITE(round) == 8 && new_slot_index < NR_SLOTS(round)) {
		__global slot_t *p = (__global slot_t *)get_slot_ptr(ht_dst, round, new_row, new_slot_index);
		*(((__global uint *)p) + write_thread_index) = slot.ui[write_thread_index];
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	return ret;
}

/*
** Execute one Equihash round. Read from ht_src, XOR colliding pairs of Xi,
** store them in ht_dst. Each work group processes only one row at a time.
*/

void equihash_round(uint round,
					__global char *ht_src,
					__global char *ht_dst,
					__global uint *debug,
					__local uint  *slot_cache,
					__local uint *collision_array,
					__local uint *nr_collisions,
					__global uint *rowCountersSrc,
					__global uint *rowCountersDst,
					__local uint *bin_first_slots,
					__local SLOT_INDEX_TYPE *bin_next_slots,
                    __local SLOT_INDEX_TYPE *new_slot_indexes)
{	
	__global char *p;
	uint     i, j;
	uint     dropped_coll = 0;
	uint     dropped_stor = 0;
	__local uint  *a, *b;

	// the mask is also computed to read data from the previous round
#define BIN_MASK(round)        ((((round) + 1) % 2) ? 0xf000 : 0xf0000)
#define BIN_MASK_OFFSET(round) ((((round) + 1) % 2) ? 3 * 4 : 4 * 4)

#define BIN_MASK2(round) ((NR_ROWS_LOG(round) == 12) ? ((((round) + 1) % 2) ? 0x00f0 : 0xf000) : \
                          (NR_ROWS_LOG(round) == 13) ? ((((round) + 1) % 2) ? 0x00e0 : 0xe000) : \
                          (NR_ROWS_LOG(round) == 14) ? ((((round) + 1) % 2) ? 0x00c0 : 0xc000) : \
                          (NR_ROWS_LOG(round) == 15) ? ((((round) + 1) % 2) ? 0x0080 : 0x8000) : \
                                                       0)
#define BIN_MASK2_OFFSET(round) ((NR_ROWS_LOG(round) == 12) ? ((((round) + 1) % 2) ? 0 : 8) : \
                                 (NR_ROWS_LOG(round) == 13) ? ((((round) + 1) % 2) ? 1 : 9) : \
                                 (NR_ROWS_LOG(round) == 14) ? ((((round) + 1) % 2) ? 2 : 10) : \
                                 (NR_ROWS_LOG(round) == 15) ? ((((round) + 1) % 2) ? 3 : 11) : \
                                                              0)

#define NR_BINS_LOG(round) (20 - NR_ROWS_LOG(round))
#define NR_BINS(round) (1 << NR_BINS_LOG(round))

	__local uint nr_slots_shared;

	uint rows_per_work_item = (NR_ROWS(round - 1) + get_num_groups(0) - 1) / (get_num_groups(0));
	uint rows_per_chunk = get_num_groups(0);

	for (uint chunk = 0; chunk < rows_per_work_item; chunk++) {
		uint nr_slots = 0;
		uint assigned_row_index = get_group_id(0) + rows_per_chunk * chunk;

		if (!get_local_id(0)) 
			*nr_collisions = 0;
		for (i = get_local_id(0); i < NR_BINS(round - 1); i += get_local_size(0))
			bin_first_slots[i] = NR_SLOTS(round - 1);
		for (i = get_local_id(0); i < NR_SLOTS(round - 1); i += get_local_size(0))
			bin_next_slots[i] = NR_SLOTS(round - 1);
		if (assigned_row_index < NR_ROWS(round - 1) && get_local_id(0) == 0) {
			uint rowIdx, rowOffset;
			get_row_counters_index(round - 1, &rowIdx, &rowOffset, assigned_row_index);
			nr_slots = (rowCountersSrc[rowIdx] >> rowOffset) & ROW_MASK(round - 1);
			nr_slots = min(nr_slots, (uint)NR_SLOTS(round - 1)); // handle possible overflow in last round
			nr_slots_shared = nr_slots;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (assigned_row_index < NR_ROWS(round - 1) && get_local_id(0)) {
			nr_slots = nr_slots_shared;
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		// Perform a radix sort as slots get loaded into LDS.
		// Make sure all the work items in the work group enter the loop.
		uint i_max = nr_slots + (get_local_size(0) - nr_slots % get_local_size(0)) - 1;
		for (i = get_local_id(0); i <= i_max; i += get_local_size(0)) {
			if (assigned_row_index < NR_ROWS(round - 1) && i < nr_slots) {
				uint xi0;
#ifdef NVIDIA
				uint2 slot_data[3];
#ifdef OPTIM_SHRINKED_SLOT_CACHE
				if (i < SLOT_CACHE_SIZE(round - 1)) {
#endif
					for (j = 0; j < UINTS_IN_XI(round - 1) / 2; ++j)
						slot_data[j] = *((__global uint2 *)get_slot_ptr(ht_src, round - 1, assigned_row_index, i) + j);
					if (UINTS_IN_XI(round - 1) % 2) {
						j = UINTS_IN_XI(round - 1) - 1;
						slot_data[j / 2].s0 = *((__global uint *)get_slot_ptr(ht_src, round - 1, assigned_row_index, i) + j);
					}

					for (j = 0; j < UINTS_IN_XI(round - 1); ++j)
						slot_cache[j * SLOT_CACHE_SIZE(round - 1) + i] = (j % 2) ? slot_data[j / 2].s1 : slot_data[j / 2].s0;
#ifdef OPTIM_SHRINKED_SLOT_CACHE
				} else {
					slot_data[0] = *((__global uint2 *)get_slot_ptr(ht_src, round - 1, assigned_row_index, i) + 0);
				}
#endif
				xi0 = slot_data[0].s0;
#else
#ifdef OPTIM_SHRINKED_SLOT_CACHE
				if (i < SLOT_CACHE_SIZE(round - 1)) {
#endif
					uint xi[6];
					for (j = 0; j < UINTS_IN_XI(round - 1); ++j)
						xi[j] = *((__global uint *)get_xi_ptr(ht_src, round - 1, assigned_row_index, i) + j);
					for (j = 0; j < UINTS_IN_XI(round - 1); ++j)
						slot_cache[j * SLOT_CACHE_SIZE(round - 1) + i] = xi[j];
					xi0 = xi[0];
#ifdef OPTIM_SHRINKED_SLOT_CACHE
				} else {
					xi0 = *((__global uint *)get_xi_ptr(ht_src, round - 1, assigned_row_index, i) + 0);
				}
#endif
#endif
				uint bin_to_use =
					  ((xi0 & BIN_MASK(round - 1)) >> BIN_MASK_OFFSET(round - 1))
					| ((xi0 & BIN_MASK2(round - 1)) >> BIN_MASK2_OFFSET(round - 1));
				bin_next_slots[i] = atom_xchg(&bin_first_slots[bin_to_use], i);
			}
			barrier(CLK_LOCAL_MEM_FENCE);
		}

		barrier(CLK_LOCAL_MEM_FENCE);
		if (!get_local_id(0)) {
			*nr_collisions = 0;
		}
		uint max_slot_a_index = NR_SLOTS(round - 1) + (get_local_size(0) - NR_SLOTS(round - 1) % get_local_size(0)) - 1;
		barrier(CLK_LOCAL_MEM_FENCE);
		for (uint slot_a_index = get_local_id(0); slot_a_index <= max_slot_a_index; slot_a_index += get_local_size(0)) {
			int valid_slot_a_index = assigned_row_index < NR_ROWS(round - 1) && slot_a_index < NR_SLOTS(round - 1);
			uint slot_b_index = valid_slot_a_index ? bin_next_slots[slot_a_index] : NR_SLOTS(round - 1);
			while (slot_b_index < NR_SLOTS(round - 1)) {
				uint coll_index = atom_inc(nr_collisions);
				if (coll_index >= LDS_COLL_SIZE(round - 1)) {
					atom_dec(nr_collisions);
					++dropped_coll;
				} else {
					collision_array[coll_index] = (slot_a_index << 12) | slot_b_index;
				}
				slot_b_index = bin_next_slots[slot_b_index];
			}
			barrier(CLK_LOCAL_MEM_FENCE);

			uint nr_collisions_copy = *nr_collisions;
			barrier(CLK_LOCAL_MEM_FENCE);
			while (nr_collisions_copy > 0) {
			// while (nr_collisions_copy >= get_local_size(0) || (slot_a_index + get_local_size(0) > max_slot_a_index && nr_collisions_copy > 0) {
				uint collision, i, j;
				__local uint *a = 0, *b = 0;
				// uint write_index = get_local_id(0) % (get_local_size(0) / THREADS_PER_WRITE(round));
				uint write_index = get_local_id(0) / THREADS_PER_WRITE(round);
				if (assigned_row_index < NR_ROWS(round - 1) && write_index < nr_collisions_copy) {
					collision = collision_array[nr_collisions_copy - 1 - write_index];
					i = (collision >> 12) & 0xfff;
					j = collision & 0xfff;
#ifdef OPTIM_SHRINKED_SLOT_CACHE
					a = (i < SLOT_CACHE_SIZE(round - 1)) ? (__local uint *)&slot_cache[i] : 0;
					b = (j < SLOT_CACHE_SIZE(round - 1)) ? (__local uint *)&slot_cache[j] : 0;
#else
					a = (__local uint *)&slot_cache[i];
					b = (__local uint *)&slot_cache[j];
#endif
				}
				barrier(CLK_LOCAL_MEM_FENCE);
				if (THREADS_PER_WRITE(round) > 1) {
					dropped_stor += parallel_xor_and_store(round, ht_src, ht_dst, assigned_row_index, i, j, a, b, rowCountersDst, new_slot_indexes);
				} else {
					dropped_stor += xor_and_store(round, ht_src, ht_dst, assigned_row_index, i, j, a, b, rowCountersDst);
				}

				if (!get_local_id(0))
					*nr_collisions -= min(*nr_collisions, (uint)get_local_size(0) / THREADS_PER_WRITE(round));

				barrier(CLK_LOCAL_MEM_FENCE);
				nr_collisions_copy = *nr_collisions;
				barrier(CLK_LOCAL_MEM_FENCE);
			}
			barrier(CLK_LOCAL_MEM_FENCE);
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}

#ifdef ENABLE_DEBUG
	debug[get_global_id(0) * 2] = dropped_coll;
	debug[get_global_id(0) * 2 + 1] = dropped_stor;
#endif
}

/*
** This defines kernel_round1, kernel_round2, ..., kernel_round8.
*/

#define KERNEL_ROUND(kernel_name, N) \
__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE(N), 1, 1))) \
void kernel_name(__global char *ht_src, __global char *ht_dst, \
	__global uint *rowCountersSrc, __global uint *rowCountersDst, \
       	__global uint *debug) \
{ \
    __local uint    slot_cache[NEXT_PRIME_NO(UINTS_IN_XI(N - 1) * SLOT_CACHE_SIZE(N - 1))]; \
    __local uint    collision_array[NEXT_PRIME_NO(LDS_COLL_SIZE(N - 1))]; \
    __local uint    nr_collisions; \
	__local uint    bin_first_slots[NEXT_PRIME_NO(NR_BINS(N - 1))]; \
	__local SLOT_INDEX_TYPE bin_next_slots[NEXT_PRIME_NO(NR_SLOTS((N) - 1))]; \
	__local SLOT_INDEX_TYPE new_slot_indexes[NEXT_PRIME_NO((THREADS_PER_WRITE(N) > 1) ? LOCAL_WORK_SIZE(N) / THREADS_PER_WRITE(N) : 0)]; \
	equihash_round(N, ht_src, ht_dst, debug, slot_cache, collision_array, \
	    &nr_collisions, rowCountersSrc, rowCountersDst, bin_first_slots, bin_next_slots, new_slot_indexes); \
}
KERNEL_ROUND(kernel_round1, 1)
KERNEL_ROUND(kernel_round2, 2)
KERNEL_ROUND(kernel_round3, 3)
KERNEL_ROUND(kernel_round4, 4)
KERNEL_ROUND(kernel_round5, 5)
KERNEL_ROUND(kernel_round6, 6)
KERNEL_ROUND(kernel_round7, 7)
KERNEL_ROUND(kernel_round8, 8)



void mark_potential_sol(__global potential_sols_t *potential_sols, uint ref0, uint ref1)
{
	uint sol_i = atom_inc(&potential_sols->nr);
	if (sol_i >= MAX_POTENTIAL_SOLS)
		return;
	potential_sols->values[sol_i][0] = ref0;
	potential_sols->values[sol_i][1] = ref1;
}

/*
** Scan the hash tables to find Equihash solutions.
*/

__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE_POTENTIAL_SOLS, 1, 1)))
void kernel_potential_sols(
	__global char *ht_src,
	__global potential_sols_t *potential_sols,
	__global uint *rowCountersSrc)
{
	__local uint refs[NEXT_PRIME_NO(NR_SLOTS(PARAM_K - 1))];
	__local uint data[NEXT_PRIME_NO(NR_SLOTS(PARAM_K - 1))];
	__local volatile uint    semaphoe;
	
	uint		nr_slots;
	uint		i, j;
	__global char	*p;
	uint		ref_i, ref_j;
	__local uint    bin_first_slots[NEXT_PRIME_NO(NR_BINS(PARAM_K - 1))];
	__local SLOT_INDEX_TYPE    bin_next_slots[NEXT_PRIME_NO(NR_SLOTS(PARAM_K - 1))];

	if (!get_global_id(0))
		potential_sols->nr = 0;
	barrier(CLK_GLOBAL_MEM_FENCE);

	uint rows_per_work_item = (NR_ROWS(PARAM_K - 1) + get_num_groups(0) - 1) / (get_num_groups(0));
	uint rows_per_chunk = get_num_groups(0);

	for (uint chunk = 0; chunk < rows_per_work_item; chunk++) {
		uint assigned_row_index = get_group_id(0) + rows_per_chunk * chunk;

		__local uint nr_slots_shared;
		if (!get_local_id(0))
			semaphoe = 0;
		for (i = get_local_id(0); i < NR_BINS(PARAM_K - 1); i += get_local_size(0))
			bin_first_slots[i] = NR_SLOTS(PARAM_K - 1);
		for (i = get_local_id(0); i < NR_SLOTS(PARAM_K - 1); i += get_local_size(0))
			bin_next_slots[i] = NR_SLOTS(PARAM_K - 1);
		if (assigned_row_index < NR_ROWS(PARAM_K - 1)) {
			if (get_local_id(0) == 0) {
				uint rowIdx, rowOffset;
				get_row_counters_index(PARAM_K - 1, &rowIdx, &rowOffset, assigned_row_index);
				nr_slots = (rowCountersSrc[rowIdx] >> rowOffset) & ROW_MASK(PARAM_K - 1);
				nr_slots = min(nr_slots, (uint)NR_SLOTS(PARAM_K - 1)); // handle possible overflow in last round
				nr_slots_shared = nr_slots;
			}
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (assigned_row_index < NR_ROWS(PARAM_K - 1)) {
			if (get_local_id(0))
				nr_slots = nr_slots_shared;
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		// in the final hash table, we are looking for a match on both the bits
		// part of the previous PREFIX colliding bits, and the last PREFIX bits.
		if (assigned_row_index < NR_ROWS(PARAM_K - 1)) {
			for (i = get_local_id(0); i < nr_slots; i += get_local_size(0)) {
				ulong slot_first_8bytes = *(__global ulong *) get_slot_ptr(ht_src, PARAM_K - 1, assigned_row_index, i);
				uint ref_i = refs[i] = slot_first_8bytes >> 32;
				uint xi_first_4bytes = data[i] = slot_first_8bytes & 0xffffffff;
				uint bin_to_use =
					  ((xi_first_4bytes & BIN_MASK(PARAM_K - 1)) >> BIN_MASK_OFFSET(PARAM_K - 1))
					| ((xi_first_4bytes & BIN_MASK2(PARAM_K - 1)) >> BIN_MASK2_OFFSET(PARAM_K - 1));
				bin_next_slots[i] = atom_xchg(&bin_first_slots[bin_to_use], i);
			}
		}

		barrier(CLK_LOCAL_MEM_FENCE);
		__local ulong coll;
		if (assigned_row_index < NR_ROWS(PARAM_K - 1)) {
			for (i = get_local_id(0); i < nr_slots; i += get_local_size(0)) {
				uint data_i = data[i];
				j = bin_next_slots[i];
				while (j < NR_SLOTS(PARAM_K - 1)) {
					if (data_i == data[j] && atom_inc(&semaphoe) == 0)
						coll = ((ulong)refs[i] << 32) | refs[j];
					j = bin_next_slots[j];
				}
			}
		}

		barrier(CLK_LOCAL_MEM_FENCE);
		if (assigned_row_index < NR_ROWS(PARAM_K - 1)) {
			if (get_local_id(0) == 0 && semaphoe)
				mark_potential_sol(potential_sols, coll >> 32, coll & 0xffffffff);
		}
	}
}



/*
** Verify if a potential solution is in fact valid.
*/

__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE_SOLS, 1, 1)))
void kernel_sols(__global char *ht0,
	__global char *ht1,
	__global char *ht2,
	__global char *ht3,
	__global char *ht4,
	__global char *ht5,
	__global char *ht6,
	__global char *ht7,
	__global char *ht8,
	__global potential_sols_t *potential_sols,
	__global sols_t *sols)
{
	__local uint	inputs_a[NEXT_PRIME_NO(1 << PARAM_K)], inputs_b[NEXT_PRIME_NO(1 << (PARAM_K - 1))];
	__global char	*htabs[] = { ht0, ht1, ht2, ht3, ht4, ht5, ht6, ht7, ht8 };

	if (!get_global_id(0))
		sols->nr = 0;
	barrier(CLK_GLOBAL_MEM_FENCE);

	if (get_group_id(0) < potential_sols->nr && get_group_id(0) < MAX_POTENTIAL_SOLS) {
		__local uint dup_counter;
		if (get_local_id(0) == 0) {
			dup_counter = 0;
			inputs_a[0] = potential_sols->values[get_group_id(0)][0];
			inputs_a[1] = potential_sols->values[get_group_id(0)][1];
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		for (int round = 7; round >= 0; --round) {
			if (round % 2) {
				for (uint i = get_local_id(0); i < (1 << (8 - round)); i += get_local_size(0)) {
					inputs_b[i * 2 + 1] = *get_ref_ptr(htabs[round], round, DECODE_ROW(round, inputs_a[i]), DECODE_SLOT1(round, inputs_a[i]));
					inputs_b[i * 2] = *get_ref_ptr(htabs[round], round, DECODE_ROW(round, inputs_a[i]), DECODE_SLOT0(round, inputs_a[i]));
				}
			}
			else {
				for (uint i = get_local_id(0); i < (1 << (8 - round)); i += get_local_size(0)) {
					inputs_a[i * 2 + 1] = *get_ref_ptr(htabs[round], round, DECODE_ROW(round, inputs_b[i]), DECODE_SLOT1(round, inputs_b[i]));
					inputs_a[i * 2] = *get_ref_ptr(htabs[round], round, DECODE_ROW(round, inputs_b[i]), DECODE_SLOT0(round, inputs_b[i]));
				}
			}
			barrier(CLK_LOCAL_MEM_FENCE);
		}
		//barrier(CLK_LOCAL_MEM_FENCE);

		int	dup_to_watch = inputs_a[256 * 2 - 1];
		for (uint j = 3 + get_local_id(0); j < 256 * 2 - 2; j += get_local_size(0))
			if (inputs_a[j] == dup_to_watch)
				atomic_inc(&dup_counter);
		barrier(CLK_LOCAL_MEM_FENCE);

		// solution appears valid, copy it to sols
		__local uint sol_i;
		if (get_local_id(0) == 0 && !dup_counter)
			sol_i = atom_inc(&sols->nr);
		barrier(CLK_LOCAL_MEM_FENCE);
		if (sol_i < MAX_SOLS && !dup_counter) {
			for (uint i = get_local_id(0); i < (1 << PARAM_K); i += get_local_size(0))
				sols->values[sol_i][i] = inputs_a[i];
			if (get_local_id(0) == 0)
				sols->valid[sol_i] = 1;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
	}
}
