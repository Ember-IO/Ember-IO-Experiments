#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/3D\ Printer/uEmu.3Dprinter.elf -sram_size 128k -flash_size 92k -sram2_base 0 -sram2_size 4k -machine embedded_fuzz -allow_flash_write -d exec,nochain -fuzz_input ./fw_bug_39_input
