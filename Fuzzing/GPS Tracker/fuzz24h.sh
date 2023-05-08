#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-fuzz ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

if [[ $# -eq 0 ]]; then
  out_dir="./output"
else
  out_dir=$1
fi
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 100 -Q ./uEmu.GPSTracker.elf -sram_size 576k -flash_size 48k -flash_base 0x80000 -sram_base 0x20070000 -machine embedded_fuzz -allow_flash_write -periph_base 0x20180000 -periph_size 128k -sram2_base 0xa000 -sram2_size 640k -fuzz_input @@
