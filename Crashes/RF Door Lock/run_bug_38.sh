#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/RF\ Door\ Lock/Pretender.max32_rf_door_lock.elf -sram_size 64k -flash_size 68k -flash_base 0 -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_38_input
