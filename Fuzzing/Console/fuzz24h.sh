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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 100 -Q ./Console.elf -machine embedded_fuzz -sram_size 64k -flash_base 0 -flash_size 32k -sram_base 0x1fff0000 -fuzz_input @@
