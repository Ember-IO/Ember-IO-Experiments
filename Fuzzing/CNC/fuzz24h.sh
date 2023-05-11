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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 200 -Q ./CNC.elf -sram_size 192k -flash_size 2048k -sram2_base 0x10000000 -sram2_size 64k -machine embedded_fuzz -fuzz_input @@
