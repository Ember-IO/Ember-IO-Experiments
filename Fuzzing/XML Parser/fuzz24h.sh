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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 200 -Q ./XML_Parser.elf -sram_size 384k -flash_size 148k -machine embedded_fuzz -disable_interrupts -fuzz_input @@
