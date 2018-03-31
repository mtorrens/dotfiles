#!/bin/bash

# Configurables
ICONPAD="%{O6}"
ENTRYPAD="%{O10}"
SEPARATOR="%{O10}"
PLARR="$SEPARATOR"

# Color theme (base16-ocean)
WHITE="#c0c5ce"
BLACK="#2b303b"
BLUE="#8fa1b3"
YELLOW="#ebcb8b"
GREEN="#a3be8c"
CYAN="#96b5b4"
PURPLE="#b48ead"
RED="#bf616a"
ORANGE="#d08770"
BROWN="#ab7967"

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
  # Battery display is missing on desktop
  local next=$YELLOW
  if [[ ! -d "/sys/class/power_supply/BAT0" ]]; then
    next=$GREEN
  fi

  echo -ne "%{B$BLUE}%{F$BLACK}$ICONPAD\uf133$ENTRYPAD$(date "+%a, %b %-d")$ENTRYPAD%{B$next}%{F$BLUE}$PLARR"
}

battery() {
  local sys_dir=$1

  local ratio=`cat $sys_dir/capacity`
  local status=`cat $sys_dir/status`

  echo -ne "%{B$YELLOW}%{F$BLACK}$ICONPAD"
  if [[ "$status" == "Charging" ]]; then
    echo -ne "\uf1e6"
  elif [[ "$status" == "Discharging" ]]; then
    # A discharging battery icon
    if [[ "$ratio" -ge 88 ]]; then
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
  elif [[ ( "$status" == "Unknown" ) && ( "$ratio" -lt 10 ) ]]; then
    # If the status is "unknown," but the battery is empty, then that probably
    # means it's discharged
    echo -ne "\uf057"
  else
    # Status is either "full" or "unknown," but the battery's not empty, so I
    # don't really know what else that means
    echo -ne "\uf14a"
  fi

  echo -ne "$ENTRYPAD$ratio%$ENTRYPAD"
}

batteries() {
  if [[ -d "/sys/class/power_supply/BAT0" ]]; then
    battery /sys/class/power_supply/BAT0

    if [[ -d "/sys/class/power_supply/BAT1" ]]; then
      echo -ne $ENTRYPAD
      battery /sys/class/power_supply/BAT1
    fi
    echo -ne "%{B$GREEN}%{F$YELLOW}$PLARR"
  fi
}

network() {
  local rx=0 tx=0 tmp_rx tmp_tx next=$CYAN

  # Wifi display is missing on desktop
  if [[ "$wifi_ifaces" == "" || ! -e '/usr/bin/nmcli' ]]; then
    next=$PURPLE
  fi

  for iface in $ifaces; do
    read tmp_rx < "/sys/class/net/${iface}/statistics/rx_bytes"
    read tmp_tx < "/sys/class/net/${iface}/statistics/tx_bytes"
    rx=$(( rx + tmp_rx ))
    tx=$(( tx + tmp_tx ))
  done

  echo -ne "%{B$GREEN}%{F$BLACK}$ICONPAD\uf0ac$ENTRYPAD$(readable_bytes $(( rx - last_rx )))\uf0d7$ENTRYPAD$(readable_bytes $(( tx - last_tx )))\uf0d8$ENTRYPAD%{B$next}%{F$GREEN}$PLARR"

  last_rx=$rx
  last_tx=$tx
}

wifi() {
  if [[ "$wifi_ifaces" == "" || ! -e '/usr/bin/nmcli' ]]; then
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

dropbox() {
  local next=$RED
  if [[ -e /usr/bin/mpc ]]; then
    next=$CYAN
  fi

  echo -ne "%{B$PURPLE}%{F$BLACK}$ICONPAD\uf16b$ENTRYPAD`dropbox-cli status | sed -n 1p`$ENTRYPAD%{B$next}%{F$PURPLE}$PLARR"
}

mpd() {
  if [[ ! -e /usr/bin/mpc ]]; then
    return
  fi

  local notify_1=`mpc current -f '%artist% - %title%' | sed 's@:@-@g'`
  local notify_2=`mpc current -f 'track ##%track% of %album%' | sed 's@:@-@g'`
  echo -ne "%{B$CYAN}%{F$BLACK}%{A:notify-send '$notify_1' '$notify_2':}$ICONPAD\uf001$ENTRYPAD`mpc current -f '%artist% - %title%'`$ENTRYPAD%{A}%{B$RED}%{F$CYAN}$PLARR"
}

zzz() {
  if xset q | grep -ql "DPMS is Enabled"; then
    echo -ne "%{A:sh ~/.config/bar/screenon.sh:}\uf186%{A}"
  else
    echo -ne "%{A:sh ~/.config/bar/screenoff.sh:}\uf185%{A}"
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

locale() {
  echo -ne "%{A:sh ~/bin/toggle-europe:}"
  if timedatectl status | grep -ql "America/Chicago"; then
    echo -ne "\uf155"
  else
    echo -ne "\uf153"
  fi
  echo -ne "%{A}"
}

while true; do
  workspace
  clock
  calendar
  batteries
  network
  wifi
  dropbox
  mpd
  echo -ne "%{B$RED}%{F$BLACK}$ICONPAD"
  zzz
  echo -ne $ICONPAD
  redshift
  echo -ne $ICONPAD
  locale
  echo -ne "$ENTRYPAD%{B-}%{F$RED}$PLARR%{F-}"
  echo ''

  sleep 1
done

