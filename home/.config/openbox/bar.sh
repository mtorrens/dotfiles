#!/bin/bash

clock() {
  echo -ne "\uf017 $(date "+%H:%M")"
}

calendar() {
  echo -ne "\uf133 $(date "+%a, %b %d")"
}

battery() {
  sys_dir=$1

  current=`cat $sys_dir/energy_now`
  full=`cat $sys_dir/energy_full`
  ratio=$((current * 100 / full))

  if [[ `cat /sys/class/power_supply/AC/online` -eq 1 ]]; then
    echo -ne "\uf1e6 "
  elif [[ "$ratio" -ge 88 ]]; then
    echo -ne "\uf240 "
  elif [[ "$ratio" -ge 63 ]]; then
    echo -ne "\uf241 "
  elif [[ "$ratio" -ge 38 ]]; then
    echo -ne "\uf242 "
  elif [[ "$ratio" -ge 12 ]]; then
    echo -ne "\uf243 "
  else
    echo -ne "\uf244 "
  fi

  echo -ne "$ratio%"
}

batteries() {
  if [[ -d "/sys/class/power_supply/BAT0" ]]; then
    echo -ne "$(battery /sys/class/power_supply/BAT0)"
  fi
  if [[ -d "/sys/class/power_supply/BAT1" ]]; then
    echo -ne "%{O16}$(battery /sys/class/power_supply/BAT1)"
  fi
}

zzz() {
  if xset q | grep -ql "DPMS is Enabled"; then
    echo "%{A:xset -dpms:}\uf186%{A}"
  else
    echo "%{A:xset +dpms:}\uf185%{A}"
  fi
}

while true; do
  echo -e "%{O16}$(clock)%{O32}$(calendar)%{O32}$(batteries)%{O32}$(zzz)"
  sleep 1
done

