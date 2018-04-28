#!/bin/bash

line=''

# Configurables
ICONPAD="%{O6}"
ENTRYPAD="%{O10}"
SEPARATOR="%{O10}"
PLARR="$SEPARATOR"
SLEEP_DELAY=3

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
  local ret=''
  if [ $kib -lt 0 ]; then
    ret+="?k"
  elif [ $kib -gt 1024 ]; then
    local mib_int=$(( kib >> 10 ))
    local mib_dec=$(( kib % 1024 * 976 / 10000 ))
    if [ "$mib_dec" -lt 10 ]; then
      mib_dec="0${mib_dec}"
    fi
    ret+="${mib_int}.${mib_dec}m"
  else
    ret+="${kib}k"
  fi
  echo $ret
}


workspace() {
  num=`i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name'`
  line+="%{B$ORANGE}%{F$BLACK}$ICONPAD\uf108$ENTRYPAD%{T4}$num%{T-}$ENTRYPAD%{B$WHITE}%{F$ORANGE}$PLARR"
}

clock() {
  line+="%{B$WHITE}%{F$BLACK}$ICONPAD\uf017$ENTRYPAD%{T4}$(date "+%H:%M")%{T-}$ENTRYPAD%{B$BLUE}%{F$WHITE}$PLARR"
}

calendar() {
  # Battery display is missing on desktop
  local next=$YELLOW
  if [[ ! -d "/sys/class/power_supply/BAT0" ]]; then
    next=$GREEN
  fi

  line+="%{B$BLUE}%{F$BLACK}$ICONPAD\uf133$ENTRYPAD$(date "+%a, %b %-d")$ENTRYPAD%{B$next}%{F$BLUE}$PLARR"
}

battery() {
  local sys_dir=$1

  local ratio=`cat $sys_dir/capacity`
  local status=`cat $sys_dir/status`

  line+="%{B$YELLOW}%{F$BLACK}$ICONPAD"
  if [[ "$status" == "Charging" ]]; then
    line+="\uf1e6"
  elif [[ "$status" == "Discharging" ]]; then
    # A discharging battery icon
    if [[ "$ratio" -ge 88 ]]; then
      line+="\uf240"
    elif [[ "$ratio" -ge 63 ]]; then
      line+="\uf241"
    elif [[ "$ratio" -ge 38 ]]; then
      line+="\uf242"
    elif [[ "$ratio" -ge 12 ]]; then
      line+="\uf243"
    else
      line+="\uf244"
    fi
  elif [[ ( "$status" == "Unknown" ) && ( "$ratio" -lt 10 ) ]]; then
    # If the status is "unknown," but the battery is empty, then that probably
    # means it's discharged
    line+="\uf057"
  else
    # Status is either "full" or "unknown," but the battery's not empty, so I
    # don't really know what else that means
    line+="\uf14a"
  fi

  line+="$ENTRYPAD$ratio%$ENTRYPAD"
}

batteries() {
  if [[ -d "/sys/class/power_supply/BAT0" ]]; then
    battery /sys/class/power_supply/BAT0

    if [[ -d "/sys/class/power_supply/BAT1" ]]; then
      line+=$ENTRYPAD
      battery /sys/class/power_supply/BAT1
    fi
    line+="%{B$GREEN}%{F$YELLOW}$PLARR"
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

  readable_rx=$(readable_bytes $(( ( rx - last_rx ) / SLEEP_DELAY )))
  readable_tx=$(readable_bytes $(( ( tx - last_tx ) / SLEEP_DELAY )))

  line+="%{B$GREEN}%{F$BLACK}$ICONPAD\uf0ac$ENTRYPAD$readable_rx%{O3}\uf0d7$ENTRYPAD$readable_tx%{O3}\uf0d8$ENTRYPAD%{B$next}%{F$GREEN}$PLARR"

  last_rx=$rx
  last_tx=$tx
}

wifi() {
  if [[ "$wifi_ifaces" == "" || ! -e '/usr/bin/nmcli' ]]; then
    return
  fi

  line+="%{B$CYAN}%{F$BLACK}%{A:networkmanager_dmenu:}$ICONPAD\uf1eb$ENTRYPAD"

  if iwconfig 2>&1 | grep -q 'ESSID:off/any'; then
    line+="<disconnected>"
  else
    ssid=`iwconfig 2>&1 | grep ESSID | sed 's@.* ESSID:"\(.*\)"@\1@'`
    line+=$ssid
  fi

  line+="$ENTRYPAD%{A}%{B$PURPLE}%{F$CYAN}$PLARR"
}

dropbox() {
  local next=$RED
  if [[ -e /usr/bin/exaile ]]; then
    next=$CYAN
  fi

  line+="%{B$PURPLE}%{F$BLACK}$ICONPAD\uf16b$ENTRYPAD`dropbox-cli status | sed -n 1p`$ENTRYPAD%{B$next}%{F$PURPLE}$PLARR"
}

music() {
  if [[ ! -e /usr/bin/exaile ]]; then
    return
  fi

  local artist_title="$(export PYTHONIOENCODING=utf-8 && exaile --get-artist) - $(export PYTHONIOENCODING=utf-8 && exaile --get-title)"
  local notify_1=`echo $artist_title | sed 's@:@-@g'`
  local notify_2=$(export PYTHONIOENCODING=utf-8 && exaile --get-album | sed 's@:@-@g')

  line+="%{B$CYAN}%{F$BLACK}%{A:notify-send '$notify_1' '$notify_2':}$ICONPAD\uf001$ENTRYPAD$artist_title$ENTRYPAD%{A}%{B$RED}%{F$CYAN}$PLARR"
}

zzz() {
  if xset q | grep -ql "DPMS is Enabled"; then
    line+="%{A:sh ~/.config/bar/screenon.sh:}\uf186%{A}"
  else
    line+="%{A:sh ~/.config/bar/screenoff.sh:}\uf185%{A}"
  fi
}

redshift() {
  local out=`pgrep redshift`
  if [[ "$out" == "" ]]; then
    line+="%{A:redshift &:}\uf070%{A}"
  else
    line+="%{A:killall redshift:}\uf06e%{A}"
  fi
}

locale() {
  line+="%{A:sh ~/bin/toggle-europe:}"
  if timedatectl status | grep -ql "America/Chicago"; then
    line+="\uf155"
  else
    line+="\uf153"
  fi
  line+="%{A}"
}

while true; do
  line=''

  workspace
  clock
  calendar
  batteries
  network
  wifi
  dropbox
  music
  line+="%{B$RED}%{F$BLACK}$ICONPAD"
  zzz
  line+=$ICONPAD
  redshift
  line+=$ICONPAD
  locale
  line+="$ENTRYPAD%{B-}%{F$RED}$PLARR%{F-}"

  echo -e $line

  sleep $SLEEP_DELAY
done

