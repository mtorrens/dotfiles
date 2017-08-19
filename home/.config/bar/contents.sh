#!/bin/bash

# Configurables
ICONPAD="%{O6}"
ENTRYPAD="%{O10}"
SEPARATOR="%{O10}"
PLARR=""

# Auto detect network interfaces
ifaces=$(ls /sys/class/net | grep -E '^(eth|wlan|enp|wlp)')

# Storage for network rate measurement
last_rx=0
last_tx=0

readable_bytes() {
  local bytes=$1
  local kib=$(( bytes >> 10 ))
  if [ $kib -lt 0 ]; then
    echo -n "? K"
  elif [ $kib -gt 1024 ]; then
    local mib_int=$(( kib >> 10 ))
    local mib_dec=$(( kib % 1024 * 976 / 10000 ))
    if [ "$mib_dec" -lt 10 ]; then
      mib_dec="0${mib_dec}"
    fi
    echo -n "${mib_int}.${mib_dec} M"
  else
    echo -n "${kib} K"
  fi
}


clock() {
  echo -ne "%{B#d3d9c8}%{F#2d2d2d}$ICONPAD\uf017$ENTRYPAD$(date "+%H:%M")$ENTRYPAD%{B#6699cc}%{F#d3d9c8}$PLARR"
}

calendar() {
  echo -ne "%{B#6699cc}%{F#2d2d2d}$ICONPAD\uf133$ENTRYPAD$(date "+%a, %b %d")$ENTRYPAD%{B#ffcc66}%{F#6699cc}$PLARR"
}

battery() {
  local sys_dir=$1

  local current=`cat $sys_dir/energy_now`
  local full=`cat $sys_dir/energy_full`
  local ratio=$((current * 100 / full))

  echo -ne "%{B#ffcc66}%{F#2d2d2d}$ICONPAD"
  if [[ `cat /sys/class/power_supply/AC/online` -eq 1 ]]; then
    echo -ne "\uf1e6"
  elif [[ "$ratio" -ge 88 ]]; then
    echo -ne "\uf240"
  elif [[ "$ratio" -ge 63 ]]; then
    echo -ne "\uf241"
  elif [[ "$ratio" -ge 38 ]]; then
    echo -ne "\uf242"
  elif [[ "$ratio" -ge 12 ]]; then
    echo -ne "\uf243"
  else
    echo -ne "\uf244"
  fi

  echo -ne "$ENTRYPAD$ratio%$ENTRYPAD"
}

batteries() {
  if [[ -d "/sys/class/power_supply/BAT0" ]]; then
    battery /sys/class/power_supply/BAT0
  fi
  if [[ -d "/sys/class/power_supply/BAT1" ]]; then
    echo -ne $ENTRYPAD
    battery /sys/class/power_supply/BAT1
  fi
  echo -ne "%{B#99cc99}%{F#ffcc66}$PLARR"
}

network() {
  local rx=0 tx=0 tmp_rx tmp_tx

  for iface in $ifaces; do
    read tmp_rx < "/sys/class/net/${iface}/statistics/rx_bytes"
    read tmp_tx < "/sys/class/net/${iface}/statistics/tx_bytes"
    rx=$(( rx + tmp_rx ))
    tx=$(( tx + tmp_tx ))
  done

  echo -ne "%{B#99cc99}%{F#2d2d2d}$ICONPAD\uf0ac$ENTRYPAD$(readable_bytes $(( rx - last_rx )))\uf0d7$ENTRYPAD$(readable_bytes $(( tx - last_tx )))\uf0d8$ENTRYPAD%{B#2d2d2d}%{F#99cc99}$PLARR"

  last_rx=$rx
  last_tx=$tx
}

zzz() {
  if xset q | grep -ql "DPMS is Enabled"; then
    echo -ne "%{A:xset -dpms:}\uf186%{A}"
  else
    echo -ne "%{A:xset +dpms:}\uf185%{A}"
  fi
}

while true; do
  clock
  echo -ne $SEPARATOR
  calendar
  echo -ne $SEPARATOR
  batteries
  echo -ne $SEPARATOR
  network
  echo -ne $SEPARATOR
  zzz
  echo ''

  sleep 1
done

