#!/usr/bin/env bash

systemctl --user import-environment DISPLAY WAYLAND_DISPLAY &
way-displays &
dunst &
blueman-applet &
swayidle before-sleep swaylock lock swaylock &