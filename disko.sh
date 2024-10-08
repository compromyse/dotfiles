#!/usr/bin/env bash

sudo nix \
  --experimental-features "nix-command flakes" \
  run github:nix-community/disko -- --mode disko ./disko.nix \
  --arg device '"/dev/nvme0n1"'
