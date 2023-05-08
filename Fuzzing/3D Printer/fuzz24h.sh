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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 150 -Q ./uEmu.3Dprinter.elf -sram_size 128k -flash_size 92k -sram2_base 0 -sram2_size 4k -machine embedded_fuzz -allow_flash_write -fuzz_input @@
