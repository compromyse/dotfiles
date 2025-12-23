#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [machine]"
    exit
fi

MACHINE="$1"

sudo cp -rv * /mnt/config

CONFIG_ARGS="--root /mnt"
# TODO: only no-filesystems for g15 and thinkpad
CONFIG_ARGS="$CONFIG_ARGS --no-filesystems"

sudo nixos-generate-config $CONFIG_ARGS

cd /mnt/config
sudo mv -v /mnt/etc/nixos/hardware-configuration.nix machines/$MACHINE/hardware-configuration.nix
sudo rm -rfv /mnt/etc

sudo nixos-install --root /mnt --no-root-password --no-channel-copy --flake .#$MACHINE
