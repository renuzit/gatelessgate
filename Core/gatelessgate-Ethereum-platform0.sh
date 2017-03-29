#!/bin/sh
GPU_FORCE_64BIT_PTR=1 GPU_MAX_HEAP_SIZE=100 GPU_USE_SYNC_OBJECTS=1 GPU_MAX_ALLOC_PERCENT=100 GPU_SINGLE_ALLOC_PERCENT=100 ./gatelessgate --gpu-platform 0 -k ethash-new -o stratum+tcp://eu1.ethermine.org:4444 -u 0x91fa32e00b0f365d629fb625182a83fed61f0642.gatelessgate -p x --xintensity 4620 --worksize 192 --gpu-threads 2 --no-extranonce

