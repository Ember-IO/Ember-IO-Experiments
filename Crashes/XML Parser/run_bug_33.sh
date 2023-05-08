#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/XML\ Parser/XML_Parser.elf -sram_size 384k -flash_size 148k -machine embedded_fuzz -disable_interrupts -d exec,nochain -fuzz_input ./fw_bug_33_input
