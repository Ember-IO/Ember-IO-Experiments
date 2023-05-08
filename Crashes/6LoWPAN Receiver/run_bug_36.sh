#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/6LoWPAN\ Receiver/HAL.atmel_6lowpan_udp_rx.elf -sram_size 256k -flash_size 72k -flash_base 0x0 -periph_base 0x805000 -periph_size 40k -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_36_input
