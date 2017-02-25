#!/bin/sh
GPU_FORCE_64BIT_PTR=1 GPU_MAX_HEAP_SIZE=100 GPU_USE_SYNC_OBJECTS=1 GPU_MAX_ALLOC_PERCENT=100 GPU_SINGLE_ALLOC_PERCENT=100 ./gatelessgate -k equihash --gpu-threads 4 --gpu-platform 0 -o stratum+tcp://us1-zcash.flypool.org:3333 -u t1NwUDeSKu4BxkD58mtEYKDjzw5toiLfmCu -p z -I 31
