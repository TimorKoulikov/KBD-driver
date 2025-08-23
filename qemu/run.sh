#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
BASE_DIR="$(dirname "$SCRIPT_DIR")"

rm -f $SCRIPT_DIR/my_image.img

qemu-img create $SCRIPT_DIR/my_image.img 512M
mkfs.ext4 $SCRIPT_DIR/my_image.img
mkdir -p $SCRIPT_DIR/mnt
sudo mount $SCRIPT_DIR/my_image.img $SCRIPT_DIR/mnt
sudo cp $BASE_DIR/driver/* $SCRIPT_DIR/mnt
sudo umount $SCRIPT_DIR/mnt

sudo qemu-system-x86_64 \
  -kernel /boot/vmlinuz \
  -initrd /boot/initrd.img \
  -m 512m \
  -append "root=/dev/sda" \
  -drive format=raw,file=$SCRIPT_DIR/my_image.img
