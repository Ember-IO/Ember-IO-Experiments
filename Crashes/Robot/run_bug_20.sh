#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Robot/Robot.elf -sram_size 256k -flash_size 44k -cpu cortex-m3 -machine embedded_fuzz -sram2_base 0 -sram2_size 4k -d exec,nochain -fuzz_input ./fw_bug_20_input
