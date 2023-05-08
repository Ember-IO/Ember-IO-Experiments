#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/CNC/CNC.elf -sram_size 192k -flash_size 2048k -sram2_base 0x10000000 -sram2_size 64k -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_18_input
