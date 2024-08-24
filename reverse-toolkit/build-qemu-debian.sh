#!/bin/bash

function INFO() {
    echo "[INFO] $1"
}

function ERROR() {
    echo "[ERROR] $1"
}

function check_root() {
    if [ "$EUID" -ne 0 ]; then
        ERROR "Please run as root"
        exit 1
    fi
}

check_root

# Install dependencies
INFO "Installing dependencies"
apt-get update
apt-get install -y git build-essential libglib2.0-dev libpixman-1-dev

# check if qemu-xtensa-esp32s2 folder exists
if [ -d "qemu-xtensa-esp32s2" ]; then
    INFO "qemu-xtensa-esp32s2 folder already exists"
    cd qemu-xtensa-esp32s2
    git pull
else
    INFO "Cloning qemu-xtensa-esp32s2"
    git clone --recursive --depth=2 https://github.com/Ebiroll/qemu-xtensa-esp32s2
    cd qemu-xtensa-esp32s2
fi

# Build qemu
INFO "Building qemu"
mkdir -p build
cd build
../configure
make -j$(nproc)
make install

INFO "Done"