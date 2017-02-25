@echo off
@set GPU_FORCE_64BIT_PTR 1
@set GPU_MAX_HEAP_SIZE 100
@set GPU_USE_SYNC_OBJECTS 1
@set GPU_MAX_ALLOC_PERCENT 100
@set GPU_SINGLE_ALLOC_PERCENT 100
gatelessgate.exe -k pascal --gpu-platform 0 -o stratum+tcp://pasc.suprnova.cc:5279 -u zawawa.gatelessgate -p x -g 1 -I 21 -w 64
pause
