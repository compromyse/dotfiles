#!/bin/bash
chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Hibernate\n󰗼  Log Out\n  Lock" | rofi -dmenu -i -p "Choice:")

case "$chosen" in
	"  Power Off") poweroff ;;
	"  Restart") reboot ;;
	"  Suspend") systemctl suspend-then-hibernate ;;
	"  Hibernate") systemctl hibernate ;;
	"󰗼  Log Out") killall dwm ;;
	"  Lock") betterlockscreen -l ;;
	*) exit 1 ;;
esac
