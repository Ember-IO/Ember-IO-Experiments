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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 100 -Q ./uEmu.uTasker_MODBUS.elf -sram_size 192k -flash_size 92k -flash_base 0x8000000 -machine embedded_fuzz -allow_flash_write -sram2_size 4k -sram2_base 0 -passthrough 4002900c,4002904c -fuzz_input @@
