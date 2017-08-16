#!/bin/bash

# The left-hand monitor will be located at coords 0,0
monline=`xrandr -q | grep '+0+0'`
monx=`echo $monline | sed "s@.* \([0-9]\+\)x[0-9]\+.*@\1@"`

$HOME/.config/openbox/bar.sh | lemonbar -p -g ${monx}x18+0+0 \
    -F '#d3d0c8' -B '#2d2d2d' \
    -f '-gohu-gohufont-medium-r-normal--14-*-*-*-*-*-*-*' \
    -f '-gohu-gohufont-bold-r-normal--14-*-*-*-*-*-*-*' \
    -f "Font Awesome" | bash &

sleep 1

trayx=$((monx - 320))

stalonetray --geometry 20x1+${trayx}+0 &
