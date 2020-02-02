FROM rust:latest

WORKDIR /setup

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # Verify git, process tools installed
    && apt-get -y install git iproute2 procps \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install toolchain for RV32/RV64 from SiFive
RUN wget https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz \
    && tar xf riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14.tar.gz \
    && mv riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14 /opt/riscv64-toolchain
ENV PATH $PATH:/opt/riscv64-toolchain/bin

# Install QEMU
RUN wget https://download.qemu.org/qemu-4.2.0.tar.xz \
    && tar xf qemu-4.2.0.tar.xz \
    && cd qemu-4.2.0/ \
    && mkdir build \
    && cd build/ \
    && ../configure --target-list=riscv32-softmmu --prefix=/opt/qemu-riscv \
    && make \
    && make install
ENV PATH $PATH:/opt/qemu-riscv/bin

# Add cross compilation target for RV32GC
RUN rustup target add riscv32imac-unknown-none-elf

CMD ["bash"]
