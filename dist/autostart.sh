#!/usr/bin/env bash

systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
sudo vfio-unbind &
way-displays &
dunst &
blueman-applet &
swayidle before-sleep swaylock lock swaylock &
