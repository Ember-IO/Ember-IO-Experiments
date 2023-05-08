#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/Zephyr\ SocketCAN/uEmu.zephyrsocketcan.elf -sram_size 64k -flash_size 134k -machine embedded_fuzz -d exec,nochain -fuzz_input ./bug_input
