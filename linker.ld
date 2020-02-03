OUTPUT_ARCH(riscv)

ENTRY(_start)
EXTERN(abort);

SECTIONS
{
    /* Here boot loader (written in `.boot` section) starts from the address 0x80000000. */
    . = 0x80000000;
    .reset : 
    {
        KEEP(*(.boot));
    }

    /* text: Program code */
    .text :
    {
        *(.text. text.*);
    }

    /* rodata: Read-only data */
    .rodata :
    {
        *(.rdata .rodata. rodata.*);
    }

    /* data: Writable data */
    .data :
    {
        *(.data .data.*);
    }

    /* bss: 0-initialized writable data */
    _bss_start = .;
    .bss :
    {
        *(.bss .bss.*);
    }
}
