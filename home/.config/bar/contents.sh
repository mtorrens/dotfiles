#!/bin/bash

# Configurables
ICONPAD="%{O6}"
ENTRYPAD="%{O10}"
SEPARATOR="%{O10}"
PLARR=""

# Color theme
WHITE="#d3d9c8"
BLACK="#2d2d2d"
BLUE="#6699cc"
YELLOW="#ffcc66"
GREEN="#99cc99"
CYAN="#66cccc"
PURPLE="#cc99cc"
RED="#f2777a"
ORANGE="#f99157"
BROWN="#d27b53"

# Auto detect network interfaces
ifaces=$(ls /sys/class/net | grep -E '^(eth|wlan|enp|wlp)')
wifi_ifaces=$(ls /sys/class/net | grep -E '^(wlan|wlp)')

# Storage for network rate measurement
last_rx=0
last_tx=0

readable_bytes() {
  local bytes=$1
  local kib=$(( bytes >> 10 ))
  if [ $kib -lt 0 ]; then
    echo -n "?k"
  elif [ $kib -gt 1024 ]; then
    local mib_int=$(( kib >> 10 ))
    local mib_dec=$(( kib % 1024 * 976 / 10000 ))
    if [ "$mib_dec" -lt 10 ]; then
      mib_dec="0${mib_dec}"
    fi
    echo -n "${mib_int}.${mib_dec}m"
  else
    echo -n "${kib}k"
  fi
}


workspace() {
  num=`i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name'`
  echo -ne "%{B$ORANGE}%{F$BLACK}$ICONPAD\uf108$ENTRYPAD$num$ENTRYPAD%{B$WHITE}%{F$ORANGE}$PLARR"
}

clock() {
  echo -ne "%{B$WHITE}%{F$BLACK}$ICONPAD\uf017$ENTRYPAD$(date "+%H:%M")$ENTRYPAD%{B$BLUE}%{F$WHITE}$PLARR"
}

calendar() {
  echo -ne "%{B$BLUE}%{F$BLACK}$ICONPAD\uf133$ENTRYPAD$(date "+%a, %b %d")$ENTRYPAD%{B$YELLOW}%{F$BLUE}$PLARR"
}

battery() {
  local sys_dir=$1

  local current=`cat $sys_dir/energy_now`
  local full=`cat $sys_dir/energy_full`
  local ratio=$((current * 100 / full))

  echo -ne "%{B$YELLOW}%{F$BLACK}$ICONPAD"
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
  echo -ne "%{B$GREEN}%{F$YELLOW}$PLARR"
}

wifi() {
  if [[ "$wifi_ifaces" == "" ]]; then
    return
  fi
  if [[ ! -e '/usr/bin/nmcli' ]]; then
    return
  fi

  echo -ne "%{B$CYAN}%{F$BLACK}%{A:networkmanager_dmenu:}$ICONPAD\uf1eb$ENTRYPAD"

  if iwconfig 2>&1 | grep -q 'ESSID:off/any'; then
    echo -n "<disconnected>"
  else
    ssid=`iwconfig 2>&1 | grep ESSID | sed 's@.* ESSID:"\(.*\)"@\1@'`
    echo -ne $ssid
  fi

  echo -ne "$ENTRYPAD%{A}%{B$PURPLE}%{F$CYAN}$PLARR"
}

network() {
  local rx=0 tx=0 tmp_rx tmp_tx

  for iface in $ifaces; do
    read tmp_rx < "/sys/class/net/${iface}/statistics/rx_bytes"
    read tmp_tx < "/sys/class/net/${iface}/statistics/tx_bytes"
    rx=$(( rx + tmp_rx ))
    tx=$(( tx + tmp_tx ))
  done

  echo -ne "%{B$GREEN}%{F$BLACK}$ICONPAD\uf0ac$ENTRYPAD$(readable_bytes $(( rx - last_rx )))\uf0d7$ENTRYPAD$(readable_bytes $(( tx - last_tx )))\uf0d8$ENTRYPAD%{B$CYAN}%{F$GREEN}$PLARR"

  last_rx=$rx
  last_tx=$tx
}

dropbox() {
  echo -ne "%{B$PURPLE}%{F$BLACK}$ICONPAD\uf16b$ENTRYPAD`dropbox-cli status | sed -n 1p`$ENTRYPAD%{B$RED}%{F$PURPLE}$PLARR"
}

zzz() {
  if xset q | grep -ql "DPMS is Enabled"; then
    echo -ne "%{A:xset -dpms:}\uf186%{A}"
  else
    echo -ne "%{A:xset +dpms:}\uf185%{A}"
  fi
}

redshift() {
  local out=`pgrep redshift`
  if [[ "$out" == "" ]]; then
    echo -ne "%{A:redshift &:}\uf070%{A}"
  else
    echo -ne "%{A:killall redshift:}\uf06e%{A}"
  fi
}

while true; do
  workspace
  echo -ne $SEPARATOR
  clock
  echo -ne $SEPARATOR
  calendar
  echo -ne $SEPARATOR
  batteries
  echo -ne $SEPARATOR
  network
  echo -ne $SEPARATOR
  wifi
  echo -ne $SEPARATOR
  dropbox
  echo -ne $SEPARATOR
  echo -ne "%{B$RED}%{F$BLACK}$ICONPAD"
  zzz
  echo -ne $ICONPAD
  redshift
  echo -ne "$ENTRYPAD%{B-}%{F$RED}$PLARR%{F-}"
  echo ''

  sleep 1
done

