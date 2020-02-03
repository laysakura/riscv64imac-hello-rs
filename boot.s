/* Do not use RV64C. */
.option norvc

/**
 * `.boot` section starts here.
 * This section is allocatable ("a"), executable ("x") and contains data ("@progbits").
 */
.section .boot, "ax", @progbits

/* Declare global symbols used in this file. */
.global _start

_start:
    /* Set up stack pointer. */
    lui     sp, %hi(stacks + 1024)
    ori     sp, sp, %lo(stacks + 1024)
    /* Now jump to the rust world; __start_rust.  */
    j       __start_rust

/**
 * `.bss` section, space for 0-initialized variables, starts here.
 * Allocates 1024 bytes for stack between addresses of [stacks:, stacks: + 1024].
 */
.bss

stacks:
    .skip 1024
