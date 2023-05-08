#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/GPS\ Tracker/uEmu.GPSTracker.elf -sram_size 576k -flash_size 48k -flash_base 0x80000 -sram_base 0x20070000 -machine embedded_fuzz -allow_flash_write -periph_base 0x20180000 -periph_size 128k -sram2_base 0xa000 -sram2_size 640k -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_30_input
