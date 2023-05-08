# CNC Bug (False Positive)

Reproduction of this bug can be observed by running the script ``./run.sh``


The bug is caused by a race condition, resulting in a null pointer dereference. In the given seed, the *st_cycle_reinitialize* function checks the variable *current_block* is not null prior to being used, however, this variable can be manipulated inside of interrupt handlers. The Timer 2 interrupt handler allows *current_block* to be set to null. If the function *st_cycle_reinitialize* begins, and verifies *current_block* is not null, then Timer 2 triggers an interrupt and calls *plan_discard_current_block* to set *current_block* to null, then the interrupt handler returns, *st_cycle_reinitialize* will dereference a null pointer (With offset 0x10). However, we consider this bug a false positive, as real hardware would not continue triggering the Timer 2 interrupts after the system enters *STATE_HOLD*, a prerequisite state for reaching the *st_cycle_reinitialize* code.
