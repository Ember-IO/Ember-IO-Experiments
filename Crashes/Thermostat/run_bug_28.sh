#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Thermostat/Pretender.max32_thermostat.elf -sram_size 64k -flash_size 56k -flash_base 0 -machine embedded_fuzz -d exec,nochain -fuzz_input ./fw_bug_28_input
