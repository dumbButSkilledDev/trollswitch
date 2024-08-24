#!/bin/bash

function INFO() {
    echo "[INFO] $1"
}

if [ -d "qemu-xtensa-esp32s2" ]; then
    INFO "qemu-xtensa-esp32s2 folder already exists"
    cd qemu-xtensa-esp32s2
    git pull
else
    INFO "Cloning qemu-xtensa-esp32s2"
    git clone --recursive --depth=2 https://github.com/Ebiroll/qemu-xtensa-esp32s2
    cd qemu-xtensa-esp32s2
fi

INFO "this is not working yet"

# Build qemu
INFO "Building qemu"
mkdir -p build
cd build
../configure
make -j$(nproc)
make install

INFO "Done"

read -p "Press enter to continue"