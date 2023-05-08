# Zephyr SocketCAN

To fuzz this binary for 24 hours, run the script ``fuzz24h.sh``

To generate a summary of a fuzzing campaign, use the script ``summary.sh``. This script creates a summary folder, containing a list of all blocks reached during the fuzzing campaign, and a list of all program counter values where a crash was observed. The coverage folder contains the list of blocks discovered up to the time a given input ID was discovered.

Both of these scripts support the use of a parameter to select the folder for the fuzzing campaign. If none is supplied, the folder *./output* will be used.
