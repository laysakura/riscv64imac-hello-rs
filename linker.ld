OUTPUT_ARCH(riscv)

ENTRY(_start)
EXTERN(abort);

/* Memory map for QEMU RISC-V VirtIO Board.
 * See: https://gitlab.freedesktop.org/spice/qemu/blob/e24f44dbeab8e54c72bdaedbd35453fb2a6c38da/hw/riscv/virt.c#L51-63
 */
MEMORY {
    /* You can choose DRAM size as you like (physically you should attach enough DRAM). */
    DRAM (xw): ORIGIN = 0x80000000, LENGTH = 100K
}

SECTIONS
{
    /* The code boot loader invokes starts here from the address 0x80000000. */
    . = 0x80000000;
    .reset : {
        KEEP(*(.boot));
    } > DRAM

    /* text: Program code */
    .text : {
        *(.text. text.*);
    } > DRAM

    /* rodata: Read-only data */
    .rodata : {
        *(.rdata .rodata. rodata.*);
    } > DRAM

    /* data: Writable data */
    .data : {
        *(.data .data.*);
    } > DRAM

    /* bss: 0-initialized writable data */
    _bss_start = .;
    .bss : {
        *(.bss .bss.*);
    } > DRAM
}
