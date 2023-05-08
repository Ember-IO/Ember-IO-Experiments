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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 150 -Q ./Robot.elf -sram_size 256k -flash_size 44k -cpu cortex-m3 -machine embedded_fuzz -sram2_base 0 -sram2_size 4k -d nochain -fuzz_input @@
