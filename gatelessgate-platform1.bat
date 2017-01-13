@echo off
@set GPU_FORCE_64BIT_PTR 0
@set GPU_MAX_HEAP_SIZE 100
@set GPU_USE_SYNC_OBJECTS 1
@set GPU_MAX_ALLOC_PERCENT 100
@set GPU_SINGLE_ALLOC_PERCENT 100
gatelessgate.exe -k equihash  --gpu-threads 2 --gpu-platform 1 -o stratum+tcp://us1-zcash.flypool.org:3333 -u t1NwUDeSKu4BxkD58mtEYKDjzw5toiLfmCu -p z
pause
