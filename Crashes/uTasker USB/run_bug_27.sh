#!/bin/bash
if [[ ! -f $EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace ]]; then
  echo "Environment variable EMBER_BASE_DIR not set correctly? Exiting"
  exit
fi

echo "Running crashing input..."

$EMBER_BASE_DIR/AFLplusplus/afl-qemu-trace -kernel ../../Fuzzing/uTasker\ USB/uEmu.uTaskerV1.4_USB_STM32429ZI.elf -sram_size 256k -flash_size 88k -flash_base 0x8000000 -machine embedded_fuzz -allow_flash_write -sram2_size 4k -sram2_base 0 -d exec,nochain -fuzz_input ./fw_bug_27_input
