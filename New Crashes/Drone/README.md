# Drone Bug (False Positive)

Reproduction of this bug can be observed by running the script ``./run.sh``


The bug is caused by a race condition, resulting in unmapped memory reads. Writing to the serial port is done using a polled status register. However, the HAL also contains provisions to allow interrupt driven transmissions, which are not enabled. The UART interrupt serves multiple purposes, and fuzzing the control register inadvertently allows enabling interrupt driven writing to the serial port. If an interrupt is triggered during a polled serial write, the variable containing the number of bytes remaining to be written, *TxXferCount*, can be decremented twice, one by the polled method (At 0x80027ec), and once by the interrupt driven method (At 0x8002a7c). If this occurs on the last byte of a message, the number underflows to the 16 bit max value, 65535.

The STM32F103RB microcontroller this is built for does not have 64KB of memory, so attempting to read a 64KB buffer and write the values to a serial port is certain to cause access to unmapped memory. However, we observed the memory maps previously used to test this binary assign 1MB of SRAM, allowing this buffer to be read. Setting the assigned memory to 20KB, as found on the original hardware allows for a much shorter execution trace to uncover the crash, and still allows for normal execution in the non-crashing case. Without this change, Ember-IO still identifies crashes in the UART; the *pTxBuffPtr* value used (by the interrupt driven mode) for determining which byte to write to the serial port next continues to grow until it reaches unmapped memory.


This bug is considered a false positive, as it assumes both polled and interrupt driven modes for the serial port are being used simultaneously, while on real hardware, the control register bit indicating interrupts are enable for data transmission would not be set.
