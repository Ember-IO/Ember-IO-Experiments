#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Gateway/Gateway.elf -sram_size 256k -flash_size 44k -cpu cortex-m3 -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_21_input
