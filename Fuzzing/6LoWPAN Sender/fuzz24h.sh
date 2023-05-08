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
$EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 100 -Q ./HAL.atmel_6lowpan_udp_tx.elf -sram_size 256k -flash_size 72k -flash_base 0x0 -periph_base 0x805000 -periph_size 40k -machine embedded_fuzz -fuzz_input @@
