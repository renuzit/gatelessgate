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

/*
** Reset counters in a hash table.
*/

__kernel
void kernel_init_ht(__global char *ht, __global uint *rowCounters)
{
	if (get_global_id(0) < RC_SIZE / 4)
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

void get_row_counters_index(uint *rowIdx, uint *rowOffset, uint row)
{
	*rowIdx = row / ROWS_PER_UINT;
	*rowOffset = BITS_PER_ROW * (row % ROWS_PER_UINT);
}

uint get_row(uint round, uint xi0)
{
	uint           row;
#if NR_ROWS_LOG == 12
	if (!(round % 2))
		row = (xi0 & 0xfff);
	else
		row = ((xi0 & 0x0f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
#elif NR_ROWS_LOG == 13
	if (!(round % 2))
		row = (xi0 & 0x1fff);
	else
		row = ((xi0 & 0x1f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
#elif NR_ROWS_LOG == 14
	if (!(round % 2))
		row = (xi0 & 0x3fff);
	else
		row = ((xi0 & 0x3f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
#elif NR_ROWS_LOG == 15
	if (!(round % 2))
		row = (xi0 & 0x7fff);
	else
		row = ((xi0 & 0x7f0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
#elif NR_ROWS_LOG == 16
	if (!(round % 2))
		row = (xi0 & 0xffff);
	else
		row = ((xi0 & 0xff0f00) >> 8) | ((xi0 & 0xf0000000) >> 24);
#else
#error "unsupported NR_ROWS_LOG"
#endif
	return row;
}

uint inc_row_counter(uint round, __global uint *rowCounters, uint row)
{
	uint rowIdx, rowOffset;
	get_row_counters_index(&rowIdx, &rowOffset, row);
	uint nr_slots = atom_add(rowCounters + rowIdx, 1 << rowOffset);
	nr_slots = (nr_slots >> rowOffset) & ROW_MASK;
	if (nr_slots >= NR_SLOTS(round)) {
		// avoid overflows
		atom_sub(rowCounters + rowIdx, 1 << rowOffset);
	}
	return nr_slots;
}

uint ht_store(uint round, __global char *ht, uint i,
			  uint xi0, uint xi1, uint xi2, uint xi3, uint xi4, uint xi5, uint xi6, __global uint *rowCounters)
{
	uint row = get_row(round, xi0);
	uint nr_slots = inc_row_counter(round, rowCounters, row);
	if (nr_slots >= NR_SLOTS(round))
		return 1;
	__global char *p = get_slot_ptr(ht, round, row, nr_slots);
	slot_t slot;
	slot.slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
	slot.slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
	slot.slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
	slot.slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
	slot.slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
	slot.slot.xi[5] = ((xi6 << 24) | (xi5 >> 8));
	slot.slot.xi[UINTS_IN_XI(round)] = i;
	if (round <= 5) {
		*(__global uint8 *)p = slot.ui8;
	} else {
		*(__global uint4 *)p = slot.ui4[0];
	}
	return 0;
}




/////////////
// ROUND 1 //
/////////////

__constant ulong blake_iv_const[] =
{
	0x6a09e667f3bcc908, 0xbb67ae8584caa73b,
	0x3c6ef372fe94f82b, 0xa54ff53a5f1d36f1,
	0x510e527fade682d1, 0x9b05688c2b3e6c1f,
	0x1f83d9abfb41bd6b, 0x5be0cd19137e2179,
};

#define mix(va, vb, vc, vd, x, y) \
    va = (va + vb + x); \
vd = rotate((vd ^ va), (ulong)64 - 32); \
vc = (vc + vd); \
vb = rotate((vb ^ vc), (ulong)64 - 24); \
va = (va + vb + y); \
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
__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE_ROUND0, 1, 1)))
void kernel_round0(__constant ulong *blake_state_const, __global char *ht,
				   __global uint *rowCounters, __global uint *debug)
{
	__local ulong blake_state[64];
	__local ulong blake_iv[8];
	uint                tid = get_global_id(0);
	ulong               v[16];
	uint                inputs_per_thread = (NR_INPUTS + get_global_size(0) - 1) / get_global_size(0);
	uint                input = tid * inputs_per_thread;
	uint                input_end = (tid + 1) * inputs_per_thread;
	uint                dropped = 0;
	if (get_local_id(0) < 64)
		blake_state[get_local_id(0)] = blake_state_const[get_local_id(0)];
	if (get_local_id(0) < 8)
		blake_iv[get_local_id(0)] = blake_iv_const[get_local_id(0)];
	barrier(CLK_LOCAL_MEM_FENCE);
	while (input < input_end && input < NR_INPUTS) {
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

		// round 1
		mix(v[0], v[4], v[8], v[12], 0, word1);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 2
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], word1, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 3
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, word1);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 4
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, word1);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 5
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, word1);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 6
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], word1, 0);
		// round 7
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], word1, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 8
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, word1);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], 0, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
		// round 9
		mix(v[0], v[4], v[8], v[12], 0, 0);
		mix(v[1], v[5], v[9], v[13], 0, 0);
		mix(v[2], v[6], v[10], v[14], 0, 0);
		mix(v[3], v[7], v[11], v[15], 0, 0);
		mix(v[0], v[5], v[10], v[15], 0, 0);
		mix(v[1], v[6], v[11], v[12], 0, 0);
		mix(v[2], v[7], v[8], v[13], word1, 0);
		mix(v[3], v[4], v[9], v[14], 0, 0);
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
		ulong h[7];
		h[0] = blake_state[0] ^ v[0] ^ v[8];
		h[1] = blake_state[1] ^ v[1] ^ v[9];
		h[2] = blake_state[2] ^ v[2] ^ v[10];
		h[3] = blake_state[3] ^ v[3] ^ v[11];
		h[4] = blake_state[4] ^ v[4] ^ v[12];
		h[5] = blake_state[5] ^ v[5] ^ v[13];
		h[6] = (blake_state[6] ^ v[6] ^ v[14]) & 0xffff;

		// store the two Xi values in the hash table
#if ZCASH_HASH_LEN == 50
		dropped += ht_store(0, ht, input * 2,
							h[0] & 0xffffffff, h[0] >> 32,
							h[1] & 0xffffffff, h[1] >> 32,
							h[2] & 0xffffffff, h[2] >> 32,
							h[3] & 0xffffffff,
							rowCounters);
		dropped += ht_store(0, ht, input * 2 + 1,
			((h[3] >> 8) | (h[4] << (64 - 8))) & 0xffffffff,
							((h[3] >> 8) | (h[4] << (64 - 8))) >> 32,
							((h[4] >> 8) | (h[5] << (64 - 8))) & 0xffffffff,
							((h[4] >> 8) | (h[5] << (64 - 8))) >> 32,
							((h[5] >> 8) | (h[6] << (64 - 8))) & 0xffffffff,
							((h[5] >> 8) | (h[6] << (64 - 8))) >> 32,
							(h[6] >> 8) & 0xffffffff,
							rowCounters);
#else
#error "unsupported ZCASH_HASH_LEN"
#endif

		input++;
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
// single-thread reads, parallel writes
uint xor_and_store(uint round, __global char *ht_dst, uint row,
				   uint slot_a, uint slot_b, __local uint *ai, __local uint *bi,
				   __global uint *rowCounters
#if THREADS_PER_WRITE != 1
	, __local slot_t *slot_write_cache,
	  __local global_pointer_to_slot_t *slot_ptrs
#endif
) {
	uint ret = 0;
	uint xi0, xi1, xi2, xi3, xi4, xi5;
	uint thread_index = get_local_id(0) % THREADS_PER_WRITE;

#if NR_ROWS_LOG < 8 && NR_ROWS_LOG > 20
#error "unsupported NR_ROWS_LOG"
#endif
	slot_t slot;
	__global slot_t *p = 0;
#if THREADS_PER_WRITE != 1
	slot_ptrs[get_local_id(0)] = 0;
	barrier(CLK_LOCAL_MEM_FENCE);
#endif

	if (ai && bi) {
		xi0 = *ai;
		xi1 = *(ai += NR_SLOTS(round - 1));
		if (round <= 7) xi2 = *(ai += NR_SLOTS(round - 1));
		if (round <= 6) xi3 = *(ai += NR_SLOTS(round - 1));
		if (round <= 4) xi4 = *(ai += NR_SLOTS(round - 1));
		if (round <= 2) xi5 = *(ai += NR_SLOTS(round - 1));

		xi0 ^= *bi;
		xi1 ^= *(bi += NR_SLOTS(round - 1));
		if (round <= 7) xi2 ^= *(bi += NR_SLOTS(round - 1));
		if (round <= 6) xi3 ^= *(bi += NR_SLOTS(round - 1));
		if (round <= 4) xi4 ^= *(bi += NR_SLOTS(round - 1));
		if (round <= 2) xi5 ^= *(bi += NR_SLOTS(round - 1));

		if (!(round & 0x1)) {
			// skip padding bytes
			xi0 = (xi0 >> 24) | (xi1 << (32 - 24));
			xi1 = (xi1 >> 24) | (xi2 << (32 - 24));
			if (round <= 7) xi2 = (xi2 >> 24) | (xi3 << (32 - 24));
			if (round <= 6) xi3 = (xi3 >> 24) | (xi4 << (32 - 24));
			if (round <= 4) xi4 = (xi4 >> 24) | (xi5 << (32 - 24));
			if (round <= 2) xi5 = (xi5 >> 24);
		}

		// invalid solutions (which start happenning in round 5) have duplicate
		// inputs and xor to zero, so discard them
		if (xi0 || xi1) {
			uint new_row = get_row(round, xi0);
			uint new_slot_index = inc_row_counter(round, rowCounters, new_row);
			if (new_slot_index >= NR_SLOTS(round)) {
				ret = 1;
			} else {
#if THREADS_PER_WRITE == 1
				p
#else
				slot_ptrs[get_local_id(0)]
#endif
				    = (__global slot_t *)get_slot_ptr(ht_dst, round, new_row, new_slot_index);
			}
		}
	}

#if THREADS_PER_WRITE == 1
	if (p) {
		slot.slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
		slot.slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
		slot.slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
		slot.slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
		slot.slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
		slot.slot.xi[5] = ((xi5 >> 8));
		slot.slot.xi[UINTS_IN_XI(round)] = ENCODE_INPUTS(row, slot_a, slot_b);
		if (round <= 5)
			*(__global uint8 *)p = slot.ui8;
		else
			*(__global uint4 *)p = slot.ui4[0];
	}
#else
	barrier(CLK_LOCAL_MEM_FENCE);
	if (slot_ptrs[get_local_id(0)]) {
		slot_write_cache[get_local_id(0)].slot.xi[0] = ((xi1 << 24) | (xi0 >> 8));
		slot_write_cache[get_local_id(0)].slot.xi[1] = ((xi2 << 24) | (xi1 >> 8));
		slot_write_cache[get_local_id(0)].slot.xi[2] = ((xi3 << 24) | (xi2 >> 8));
		slot_write_cache[get_local_id(0)].slot.xi[3] = ((xi4 << 24) | (xi3 >> 8));
		slot_write_cache[get_local_id(0)].slot.xi[4] = ((xi5 << 24) | (xi4 >> 8));
		slot_write_cache[get_local_id(0)].slot.xi[5] = ((xi5 >> 8));
		slot_write_cache[get_local_id(0)].slot.xi[UINTS_IN_XI(round)] = ENCODE_INPUTS(row, slot_a, slot_b);
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	uint local_id_base = get_local_id(0) - get_local_id(0) % THREADS_PER_WRITE;
	for (uint write_index = local_id_base; write_index < local_id_base + THREADS_PER_WRITE; ++write_index) {
		if (slot_ptrs[write_index]) {
#if THREADS_PER_WRITE == 2 
			* ((__global uint4 *)slot_ptrs[write_index] + thread_index) = slot_write_cache[write_index].ui4[thread_index];
#elif THREADS_PER_WRITE == 4
			* ((__global uint2 *)slot_ptrs[write_index] + thread_index) = slot_write_cache[write_index].ui2[thread_index];
#elif THREADS_PER_WRITE == 8
			* ((__global uint *)slot_ptrs[write_index] + thread_index) = slot_write_cache[write_index].ui[thread_index];
#else
#error "unsupported THREADS_PER_WRITE"
#endif
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
#endif
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
					__local uint *nr_slots_array,
					__local uint *bin_first_slots,
					__local BIN_INDEX_TYPE *bin_next_slots)
{	
	uint globalTid = get_global_id(0) / get_local_size(0);
	uint localTid = get_local_id(0) / get_local_size(0);
	uint localGroupId = get_local_id(0) % get_local_size(0);
	__global char *p;
	uint     i, j;
	uint     dropped_coll = 0;
	uint     dropped_stor = 0;
	__local uint  *a, *b;
	// the mask is also computed to read data from the previous round
#define BIN_MASK(round)        ((((round) + 1) % 2) ? 0xf000 : 0xf0000)
#define BIN_MASK_OFFSET(round) ((((round) + 1) % 2) ? 3 * 4 : 4 * 4)
#if NR_ROWS_LOG == 12
#define BIN_MASK2(round)        ((((round) + 1) % 2) ? 0x00f0 : 0xf000)
#define BIN_MASK2_OFFSET(round) ((((round) + 1) % 2) ? 0 : 8)
#elif NR_ROWS_LOG == 13
#define BIN_MASK2(round)        ((((round) + 1) % 2) ? 0x00e0 : 0xe000)
#define BIN_MASK2_OFFSET(round) ((((round) + 1) % 2) ? 1 : 9)
#elif NR_ROWS_LOG == 14
#define BIN_MASK2(round)        ((((round) + 1) % 2) ? 0x00c0 : 0xc000)
#define BIN_MASK2_OFFSET(round) ((((round) + 1) % 2) ? 2 : 10)
#elif NR_ROWS_LOG == 15
#define BIN_MASK2(round)        ((((round) + 1) % 2) ? 0x0080 : 0x8000)
#define BIN_MASK2_OFFSET(round) ((((round) + 1) % 2) ? 3 : 11)
#elif NR_ROWS_LOG == 16
#define BIN_MASK2(round)        0
#define BIN_MASK2_OFFSET(round) 0
#else
#error "unsupported NR_ROWS_LOG"
#endif  
#define NR_BINS_LOG (20 - NR_ROWS_LOG)
#define NR_BINS (1 << NR_BINS_LOG)
#if THREADS_PER_WRITE != 1
	__local slot_t slot_write_cache[NEXT_PRIME_NO(LOCAL_WORK_SIZE)];
	__local global_pointer_to_slot_t slot_ptrs[NEXT_PRIME_NO(LOCAL_WORK_SIZE)];
#endif

	uint rows_per_work_item = (NR_ROWS + get_num_groups(0) - 1) / (get_num_groups(0));
	uint rows_per_chunk = get_num_groups(0);

	for (uint chunk = 0; chunk < rows_per_work_item; chunk++) {
		uint nr_slots = 0;
		uint assigned_row_index = globalTid + rows_per_chunk * chunk;

		if (!get_local_id(0)) 
			*nr_collisions = 0;
		for (i = localGroupId; i < NR_BINS; i += get_local_size(0))
			bin_first_slots[i] = NR_SLOTS(round - 1);
		for (i = localGroupId; i < NR_SLOTS(round - 1); i += THREADS_PER_ROW)
			bin_next_slots[i] = NR_SLOTS(round - 1);
		if (assigned_row_index < NR_ROWS && localGroupId == 0) {
			uint rowIdx, rowOffset;
			get_row_counters_index(&rowIdx, &rowOffset, assigned_row_index);
			nr_slots = (rowCountersSrc[rowIdx] >> rowOffset) & ROW_MASK;
			nr_slots = min(nr_slots, (uint)NR_SLOTS(round - 1)); // handle possible overflow in last round
			nr_slots_array[0] = nr_slots;
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (assigned_row_index < NR_ROWS && localGroupId) {
			nr_slots = nr_slots_array[0];
		}

		barrier(CLK_LOCAL_MEM_FENCE);

		// Perform a radix sort as slots get loaded into LDS.
		// Make sure all the work items in the work group enter the loop.
		uint i_max = nr_slots + (get_local_size(0) - nr_slots % get_local_size(0)) - 1;
		for (i = localGroupId; i <= i_max; i += get_local_size(0)) {
			if (assigned_row_index < NR_ROWS && i < nr_slots) {
				uint xi0;
#ifdef NVIDIA
				uint2 slot_data[3];
				for (j = 0; j < UINTS_IN_XI(round - 1) / 2; ++j)
					slot_data[j] = *((__global uint2 *)get_slot_ptr(ht_src, round - 1, assigned_row_index, i) + j);
				if (UINTS_IN_XI(round - 1) % 2) {
					j = UINTS_IN_XI(round - 1) - 1;
					slot_data[j / 2].s0 = *((__global uint *)get_slot_ptr(ht_src, round - 1, assigned_row_index, i) + j);
				}

				for (j = 0; j < UINTS_IN_XI(round - 1); ++j)
					slot_cache[j * NR_SLOTS(round - 1) + i] = (j % 2) ? slot_data[j / 2].s1 : slot_data[j / 2].s0;
				xi0 = slot_data[0].s0;
#else
				uint xi[6];
				for (j = 0; j < UINTS_IN_XI(round - 1); ++j)
					xi[j] = *((__global uint *)get_xi_ptr(ht_src, round - 1, assigned_row_index, i) + j);
				for (j = 0; j < UINTS_IN_XI(round - 1); ++j)
					slot_cache[j * NR_SLOTS(round - 1) + i] = xi[j];
				xi0 = xi[0];
#endif
				uint bin_to_use =
					  ((xi0 & BIN_MASK(round - 1)) >> BIN_MASK_OFFSET(round - 1))
					| ((xi0 & BIN_MASK2(round - 1)) >> BIN_MASK2_OFFSET(round - 1));
				bin_next_slots[i] = atom_xchg(&bin_first_slots[bin_to_use], i);
			}
			barrier(CLK_LOCAL_MEM_FENCE);
		}

		barrier(CLK_LOCAL_MEM_FENCE);
		// in order to reduce the size of collision_array[].
		if (!get_local_id(0)) {
			*nr_collisions = 0;
		}
		uint max_slot_a_index = NR_SLOTS(round - 1) + (LOCAL_WORK_SIZE - NR_SLOTS(round - 1) % LOCAL_WORK_SIZE) - 1;
		barrier(CLK_LOCAL_MEM_FENCE);
		for (uint slot_a_index = get_local_id(0); slot_a_index <= max_slot_a_index; slot_a_index += get_local_size(0)) {
			int valid_slot_a_index = assigned_row_index < NR_ROWS && slot_a_index < NR_SLOTS(round - 1);
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
				if (assigned_row_index < NR_ROWS && get_local_id(0) < nr_collisions_copy) {
					collision = collision_array[nr_collisions_copy - 1 - get_local_id(0)];
					i = (collision >> 12) & 0xfff;
					j = collision & 0xfff;
					a = (__local uint *)&slot_cache[i];
					b = (__local uint *)&slot_cache[j];
				}
				dropped_stor += xor_and_store(round, ht_dst, assigned_row_index, i, j, a, b, rowCountersDst
#if THREADS_PER_WRITE == 1
				);
#else
					, slot_write_cache, slot_ptrs);
#endif
				if (!get_local_id(0))
					*nr_collisions -= min(*nr_collisions, (uint)get_local_size(0));

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
__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE, 1, 1))) \
void kernel_name(__global char *ht_src, __global char *ht_dst, \
	__global uint *rowCountersSrc, __global uint *rowCountersDst, \
       	__global uint *debug) \
{ \
    __local uint    slot_cache[NEXT_PRIME_NO(UINTS_IN_XI(N - 1) * NR_SLOTS(N - 1))]; \
    __local uint    collision_array[NEXT_PRIME_NO(LDS_COLL_SIZE(N - 1))]; \
    __local uint    nr_collisions; \
	__local uint    nr_slots_array[NEXT_PRIME_NO(1)]; \
	__local uint    bin_first_slots[NEXT_PRIME_NO(NR_BINS)]; \
	__local BIN_INDEX_TYPE    bin_next_slots[NEXT_PRIME_NO(NR_SLOTS(N - 1))]; \
	equihash_round(N, ht_src, ht_dst, debug, slot_cache, collision_array, \
	    &nr_collisions, rowCountersSrc, rowCountersDst, nr_slots_array, bin_first_slots, bin_next_slots); \
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

// Add more bins for efficient sorting.
#define NR_BINS_SOLS         (NR_BINS << EXTRA_BITS_FOR_BINS_SOLS)
#define BIN_MASK_SOLS        (((0x1 << EXTRA_BITS_FOR_BINS_SOLS) - 1) << 12)
#define BIN_MASK_SOLS_OFFSET (20 - NR_ROWS_LOG)

__kernel __attribute__((reqd_work_group_size(LOCAL_WORK_SIZE_POTENTIAL_SOLS, 1, 1)))
void kernel_potential_sols(
	__global char *ht_src,
	__global potential_sols_t *potential_sols,
	__global uint *rowCountersSrc)
{
	__local uint refs[NEXT_PRIME_NO(NR_SLOTS(PARAM_K - 1))];
	__local uint data[NEXT_PRIME_NO(NR_SLOTS(PARAM_K - 1))];
	__local volatile uint    semaphoe;

	uint globalTid = get_global_id(0) / get_local_size(0);
	uint localTid = get_local_id(0) / get_local_size(0);
	uint localGroupId = get_local_id(0) % get_local_size(0);

	uint		nr_slots;
	uint		i, j;
	__global char	*p;
	uint		ref_i, ref_j;
	__local uint    bin_first_slots[NEXT_PRIME_NO(NR_BINS_SOLS)];
	__local BIN_INDEX_TYPE    bin_next_slots[NEXT_PRIME_NO(NR_SLOTS(PARAM_K - 1))];

	if (!get_global_id(0))
		potential_sols->nr = 0;
	barrier(CLK_GLOBAL_MEM_FENCE);

	uint rows_per_work_item = (NR_ROWS + get_num_groups(0) - 1) / (get_num_groups(0));
	uint rows_per_chunk = get_num_groups(0);

	for (uint chunk = 0; chunk < rows_per_work_item; chunk++) {
		uint assigned_row_index = globalTid + rows_per_chunk * chunk;

		__local uint nr_slots_array[1];
		if (!get_local_id(0))
			semaphoe = 0;
		for (i = localGroupId; i < NR_BINS; i += get_local_size(0))
			bin_first_slots[i] = NR_SLOTS(PARAM_K - 1);
		for (i = localGroupId; i < NR_SLOTS(PARAM_K - 1); i += THREADS_PER_ROW_SOLS)
			bin_next_slots[i] = NR_SLOTS(PARAM_K - 1);
		if (assigned_row_index < NR_ROWS) {
			if (localGroupId == 0) {
				uint rowIdx, rowOffset;
				get_row_counters_index(&rowIdx, &rowOffset, assigned_row_index);
				nr_slots = (rowCountersSrc[rowIdx] >> rowOffset) & ROW_MASK;
				nr_slots = min(nr_slots, (uint)NR_SLOTS(PARAM_K - 1)); // handle possible overflow in last round
				nr_slots_array[localTid] = nr_slots;
			}
		}
		barrier(CLK_LOCAL_MEM_FENCE);
		if (assigned_row_index < NR_ROWS) {
			if (localGroupId)
				nr_slots = nr_slots_array[localTid];
		}
		barrier(CLK_LOCAL_MEM_FENCE);

		// in the final hash table, we are looking for a match on both the bits
		// part of the previous PREFIX colliding bits, and the last PREFIX bits.
		if (assigned_row_index < NR_ROWS) {
			for (i = localGroupId; i < nr_slots; i += get_local_size(0)) {
				ulong slot_first_8bytes = *(__global ulong *) get_slot_ptr(ht_src, PARAM_K - 1, assigned_row_index, i);
				uint ref_i = refs[i] = slot_first_8bytes >> 32;
				uint xi_first_4bytes = data[i] = slot_first_8bytes & 0xffffffff;
				uint bin_to_use =
					((xi_first_4bytes & BIN_MASK(PARAM_K - 1)) >> BIN_MASK_OFFSET(PARAM_K - 1))
					| ((xi_first_4bytes & BIN_MASK2(PARAM_K - 1)) >> BIN_MASK2_OFFSET(PARAM_K - 1))
					| ((xi_first_4bytes & BIN_MASK_SOLS) >> BIN_MASK_SOLS_OFFSET);
				bin_next_slots[i] = atom_xchg(&bin_first_slots[bin_to_use], i);
			}
		}

		barrier(CLK_LOCAL_MEM_FENCE);
		__local ulong coll;
		if (assigned_row_index < NR_ROWS) {
			for (i = localGroupId; i < nr_slots; i += get_local_size(0)) {
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
		if (assigned_row_index < NR_ROWS) {
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
					inputs_b[i * 2 + 1] = *get_ref_ptr(htabs[round], round, DECODE_ROW(inputs_a[i]), DECODE_SLOT1(inputs_a[i]));
					inputs_b[i * 2] = *get_ref_ptr(htabs[round], round, DECODE_ROW(inputs_a[i]), DECODE_SLOT0(inputs_a[i]));
				}
			}
			else {
				for (uint i = get_local_id(0); i < (1 << (8 - round)); i += get_local_size(0)) {
					inputs_a[i * 2 + 1] = *get_ref_ptr(htabs[round], round, DECODE_ROW(inputs_b[i]), DECODE_SLOT1(inputs_b[i]));
					inputs_a[i * 2] = *get_ref_ptr(htabs[round], round, DECODE_ROW(inputs_b[i]), DECODE_SLOT0(inputs_b[i]));
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
