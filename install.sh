#!/usr/bin/env bash

MACHINE=x

sudo mkdir -v /mnt/persist/system
sudo cp -rv * /mnt/config

sudo nixos-generate-config --root /mnt --no-filesystems

cd /mnt/config
sudo mv -v /mnt/etc/nixos/hardware-configuration.nix machines/$MACHINE/hardware-configuration.nix
sudo rm -rfv /mnt/etc

sudo nixos-install --root /mnt --no-root-password --no-channel-copy --flake .#$MACHINE
