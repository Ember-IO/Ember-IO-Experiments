#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Heat\ Press/Heat_Press.elf -sram_size 256k -flash_size 28k -flash_base 0x80000 -sram_base 0x20070000 -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_13_input
