@echo off
@set GPU_FORCE_64BIT_PTR 0
@set GPU_MAX_HEAP_SIZE 100
@set GPU_USE_SYNC_OBJECTS 1
@set GPU_MAX_ALLOC_PERCENT 100
@set GPU_SINGLE_ALLOC_PERCENT 100
gatelessgate.exe -k neoscrypt --gpu-platform 0 -o s1.theblocksfactory.com:3333 -u zawawa.gatelessgate_128 -p x -I 13 -w 256 -g 1
pause
