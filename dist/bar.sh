#!/usr/bin/env bash
wifi() {
  iwgetid -r
}

battery() {
  c=$(cat /sys/class/power_supply/BAT1/capacity)

  if [[ $c > 85 ]]; then
    echo "  $c"
  elif [[ $c > 70 ]]; then
    echo "  $c"
  elif [[ $c > 50 ]]; then
    echo "  $c"
  elif [[ $c > 30 ]]; then
    echo "  $c"
  else
    echo "  $c"
  fi
}

charging() {
  if [[ "$(cat /sys/class/power_supply/BAT1/status)" == "Charging" ]]; then
    echo "+"
  fi
}

calendar() {
  date +'%a, %d %b %Y |   %H:%M'
}

volume() {
  pamixer --get-volume
}

while [[ true ]]; do
  dwlb -status all "| ^lm(alacritty -e nmtui-connect)  $(wifi)^lm() |   $(volume)% | $(battery)%$(charging) |   $(calendar) | λ |"
  sleep 1
done
