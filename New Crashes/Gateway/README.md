# Gateway Bug

Reproduction of this bug can be observed by running the script ``./run.sh``


The bug is caused by incorrect validation of the number of bytes received in a message. In the given seed, the *parse* function repeatedly calls the *bufferDataAtPosition* function, incrementing the counter of bytes received each time. However, when the buffer is full, *bufferDataAtPosition* does not write to the buffer, instead returning an error, but the *parse* function does not check for reported errors. When the message termination character is received, the *decodeByteStream* function attempts to change the format of the data stored in the buffer. However, the buffer length has been repeatedly incremented beyond the real length of the buffer. This causes adjacent bytes in the buffer to be corrupted. This data corruption remains unnoticed until the *bufferDataAtPosition* function is called again to store a null terminator, and the pointer of the buffer has been corrupted. When the corrupted buffer pointer is dereferenced, unmapped memory is accessed.
