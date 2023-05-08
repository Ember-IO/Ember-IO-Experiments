# 6LoWPAN Receiver Bug

Reproduction of this bug can be observed by running the script ``./run.sh``


The bug is caused by a race condition, resulting in a null pointer dereference. In the given seed, the *sio2host_init* function sets up the serial port *SERCOM0*, however, the function pointer dereferenced in *SERCOM0_Handler* is not written until near the end of the *sio2host_init* function. If the *SERCOM0* interrupt handler is triggered after the UART is initialised, but before the global pointer is written, the firmware will jump to a null pointer.
