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
    # Add cross compilation target for RV64GC
    && /root/.cargo/bin/rustup target add riscv64imac-unknown-none-elf \
    #
    # Install binutils for RV64GC
    && /root/.cargo/bin/cargo install cargo-binutils \
    && /root/.cargo/bin/rustup component add llvm-tools-preview
ENV PATH $PATH:/root/.cargo/bin

# Install toolchain for RV32/RV64 from SiFive
RUN mkdir /opt/riscv64-toolchain \
    && curl -L https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz | tar xz -C /opt
ENV PATH $PATH:/opt/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin

# Install QEMU for RV32/RV64 from SiFive
RUN mkdir /opt/qemu-riscv \
    && curl -L https://static.dev.sifive.com/dev-tools/riscv-qemu-4.1.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz | tar xz -C /opt \
    #
    # Install QEMU's runtime dependencies w/ apt
    && apt-get update \
    && apt-get -y install libseccomp2 libpixman-1-0 libnuma1 libjpeg8 libglib2.0-0
ENV PATH $PATH:/opt/riscv-qemu-4.1.0-2019.08.0-x86_64-linux-ubuntu14/bin

CMD ["bash"]
