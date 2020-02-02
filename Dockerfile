FROM ubuntu:14.04

WORKDIR /setup

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # Verify git, process tools installed
    && apt-get -y install git iproute2 procps \
    #
    # Install host's gcc for `cargo install`
    && apt-get -y install gcc \
    #
    # Install curl
    && apt-get -y install curl \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    #
    # Add cross compilation target for RV32GC
    && $HOME/.cargo/bin/rustup target add riscv32imac-unknown-none-elf \
    #
    # Install binutils for RV32GC
    && $HOME/.cargo/bin/cargo install cargo-binutils \
    && $HOME/.cargo/bin/rustup component add llvm-tools-preview
ENV PATH $PATH:$HOME/.cargo/bin

# Install toolchain for RV32/RV64 from SiFive
RUN mkdir /opt/riscv64-toolchain \
    && curl -L https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz | tar xz -C /opt/riscv64-toolchain
ENV PATH $PATH:/opt/riscv64-toolchain/bin

# Install QEMU for RV32/RV64 from SiFive
RUN mkdir /opt/qemu-riscv \
    && curl -L https://static.dev.sifive.com/dev-tools/riscv-qemu-4.1.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz | tar xz -C /opt/qemu-riscv
ENV PATH $PATH:/opt/qemu-riscv/bin

CMD ["bash"]
