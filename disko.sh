#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [disk]"
    exit
fi

DISK="$1"

# TODO: fix the device argument
sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- --mode disko ./disko.nix \
  --arg device '"/dev/nvme0n1"'
