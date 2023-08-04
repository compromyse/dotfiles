#!/bin/dash

interval=0

black=#1e1f26
white=#d3d7f2

battery() {
  get_capacity="$(cat /sys/class/power_supply/BAT1/capacity)"
  printf "^b$black^ "
  printf "^c$black^^b$white^   $get_capacity "
  printf "^b$black^ "
}

wlan() {
	case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) printf "^c$black^ ^b$white^ 󰤨 Connected ^d^";;
	down) printf "^c$black^ ^b$white^ 󰤭 Disconnected ^d^";;
	esac
}

clock() {
  printf "^b$black^  "
	printf "^c$black^^b$white^ 󱑆 $(date '+%H:%M') "
  printf "^b$black^  "
}

user() {
  printf "^c$black^^b$white^ $(whoami) "
  printf "^b$black^  "
}

while true; do

  [ $interval = 0 ] || [ $(($interval % 3600)) = 0 ]
  interval=$((interval + 1))

  sleep 5 && xsetroot -name "$(battery)$(wlan)$(clock)$(user)"
done
