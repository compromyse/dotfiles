#!/usr/bin/env bash
alacritty --title float -o 'window.dimensions = { columns = 80, lines = 40 }' -e bash -c 'virt-manager -c qemu:///system --show-domain-console $(virsh -c qemu:///system list --all --name | fzf) & disown'
