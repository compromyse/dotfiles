#!/usr/bin/env bash

way-displays &
dunst &
blueman-applet &
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY &
