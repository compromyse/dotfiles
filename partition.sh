#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [disk]"
    exit
fi

DISK="$1"

sudo parted -s $DISK mklabel gpt
sudo parted -s $DISK mkpart primary ext4 10MB 100%
sudo parted -s $DISK name 1 linux
sudo parted -s $DISK mkpart primary 1 10MB
sudo parted -s $DISK name 2 grub
sudo parted -s $DISK set 2 bios_grub on

sudo mkfs.btrfs -L linux "$DISK"1
sudo mount "$DISK"1 /mnt

sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/boot
sudo btrfs subvolume create /mnt/home
sudo btrfs subvolume create /mnt/nix
sudo btrfs subvolume create /mnt/config

sudo umount /mnt
sudo mount -o subvol=root /mnt
sudo mkdir -p /mnt/{boot,home,nix,config}

sudo mount -o subvol=boot /mnt/boot
sudo mount -o subvol=home /mnt/home
sudo mount -o subvol=nix /mnt/nix
sudo mount -o subvol=config /mnt/config
