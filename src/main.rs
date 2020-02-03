#![no_main]
#![no_std]

#[no_mangle]
pub extern "C" fn __start_rust() -> ! {
    // See: https://gitlab.freedesktop.org/spice/qemu/blob/e24f44dbeab8e54c72bdaedbd35453fb2a6c38da/hw/riscv/virt.c#L57
    let uart = 0x1000_0000 as *mut u8;

    for c in b"Hello from Rust!".iter() {
        unsafe {
            *uart = *c as u8;
        }
    }

    loop {}
}

use core::panic::PanicInfo;
#[panic_handler]
#[no_mangle]
pub fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle]
pub extern "C" fn abort() -> ! {
    loop {}
}
