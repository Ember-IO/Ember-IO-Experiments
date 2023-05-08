#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Reflow\ Oven/Reflow_Oven.elf -sram_size 256k -flash_size 48k -sram2_base 0x0 -sram2_size 4k -cpu cortex-m3 -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_26_input
