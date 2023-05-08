# Zephyr SocketCAN Bug

Reproduction of this bug can be observed by running the script ``./run.sh``

This bug was fixed in the Zephyr Project RTOS in commit 770f232a670b2f4bc359886dc3dc03f53ca2bd62, prior to our discovery of the bug through fuzzing.


The bug is caused by incorrect validation of the number of arguments passed to a function, resulting in a buffer overflow. In the given seed, the *execute* function provides too many arguments to the *shell_make_argv* function. The buffer overflows, causing the null terminator (Written from address *0x800c1d8) to be written over the adjacent stack variable. This stack corruption remains unnoticed until the *execute* function returns, and the value is popped from the stack. The popped value is meant to correspond to the *shell* pointer, and is dereferenced with an offset of 8 at address *0x80020a0*. In cases where the bug has been triggered, this results in a read of unmapped memory at address 0x8.

