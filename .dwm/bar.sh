#!/bin/bash

battery() {
  capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
  case "$(cat /sys/class/power_supply/BAT1/status)" in
    Charging) printf "  $capacity +";;
    Discharging) printf "  $capacity -";;
    Full) printf "  $capacity";;
  esac
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
    up) echo "󰤨  $(iwgetid -r)";;
	  down) printf "󰤭  Disconnected";;
	esac
}

clock() {
	printf "󱑆  $(date '+%H:%M')"
}

user() {
  printf "$(whoami)"
}

while(true) do
  xsetroot -name "| $(battery) | $(wlan) | $(clock) | $(user) " && sleep 2
done
