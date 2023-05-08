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
# Due to a strange case that causes forkserver errors when caching under rare circumstances, we disable caching in this binary

AFL_QEMU_DISABLE_CACHE=1 $EMBER_BASE_DIR/AFLplusplus/afl-fuzz -V 86400 -i ./seeds -o $out_dir -t 800 -Q ./uEmu.uTaskerV1.4_USB_STM32429ZI.elf -sram_size 256k -flash_size 88k -flash_base 0x8000000 -machine embedded_fuzz -allow_flash_write -sram2_size 4k -sram2_base 0 -fuzz_input @@
