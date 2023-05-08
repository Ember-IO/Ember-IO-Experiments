#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Drone/Drone.elf -sram_size 1024k -flash_size 52k -cpu cortex-m3 -sram2_base 0 -sram2_size 4k -machine embedded_fuzz -d exec,nochain -fuzz_input ./bug_input
