# riscv64imac-hello-rs

A "Hellow World!" running on RISC-V (riscv64imac) written in Rust.

## Features

- **Works in docker.** No need to insall compilers, linkers, and simulators by yourself.
- Compiled into **64-bit RISC-V (RV64).**
- Uses **stable rustc build.** Not nightly.
- Uses cargo. Not xargo.
- (Optional) Runs with Visual Studio Code Remote Development Container.

## Run in Docker

### In your host machine:

```bash
docker build --rm -t riscv64imac-hello-rs .
docker run -it --rm --volume ${PWD}:/source --workdir /source riscv64imac-hello-rs
```

### In the docker image:

`Ctrl-a x` to quit QEMU monitor.

```bash
root@28fa79ab4d21:/source# cargo run
   Compiling riscv64imac-hello-rs v0.1.0 (/source)
    Finished dev [unoptimized + debuginfo] target(s) in 0.31s
     Running `qemu-system-riscv64 -nographic -bios none -machine virt -kernel target/riscv64imac-unknown-none-elf/debug/riscv64imac-hello-rs`
Hello from Rust!
```

## (Optional) Run with Visual Studio Code Remote Development Container

Open Visual Studio code with:

```bash
code .
```

And select the `Remote-Containers: Add Development Container Configuration Files...` command from the Command Palette (F1) and pick a pre-defined container configuration file.
