extern crate cc;

use cc::Build;
use std::error::Error;

fn main() -> Result<(), Box<dyn Error>> {
    // assemble the `asm.s` file
    Build::new()
        .flag("-march=rv32imac")
        .flag("-mabi=ilp32")
        .file("boot.s")
        .compile("boot.o");

    Ok(())
}
