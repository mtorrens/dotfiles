#!/bin/bash

# Clean up
killall -q lemonbar
killall -q stalonetray

# The left-hand monitor will be located at coords 0,0
monline=`xrandr -q | grep '+0+0'`
monx=`echo $monline | sed "s@.* \([0-9]\+\)x[0-9]\+.*@\1@"`

barwidth=$monx #$((monx - 320)) if tray active

# For some reason, this needs to be exported here, too.
export PYTHONIOENCODING=utf-8

$HOME/.config/bar/contents.sh | lemonbar -p -g ${barwidth}x18+0+0 \
    -F '#c0c5ce' -B '#2b303b' \
    -o -1 -f 'Roboto-11' \
    -o -3 -f "Font Awesome 5 Free-10:style=Solid" \
    -o -3 -f "Font Awesome 5 Brands-10" \
    -o -1 -f "Droid Sans Mono-11" \
    -o -1 -f "Fantasque Sans Mono-11" | bash &

# If a system tray is needed, this will work
# trayx=$((monx - 320))
# stalonetray --geometry 20x1+${trayx}+0 --sticky true --kludges "force_icons_size,fix_window_pos" &
