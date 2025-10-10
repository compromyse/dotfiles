#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [disk]"
    exit
fi

DISK="$1"

sudo fdisk $DISK <<EEOF
o
n
p
1
2048
+500M
n
p
2


w
EEOF

sudo mkfs.fat -F 32 "$DISK"1
sudo fatlabel "$DISK"1 NIXBOOT
sudo mkfs.ext4 "$DISK"2 -L NIXROOT

sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot

sudo fallocate -l 2G /mnt/.swapfile
sudo chmod 600 /mnt/.swapfile
sudo mkswap /mnt/.swapfile
sudo swapon /mnt/.swapfile
