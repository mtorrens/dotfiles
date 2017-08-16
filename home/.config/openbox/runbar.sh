#!/bin/bash

$HOME/.config/openbox/bar.sh | lemonbar -p -g 1920x18+0+0 -b \
    -F '#d3d0c8' -B '#2d2d2d' \
    -f '-gohu-gohufont-medium-r-normal--14-*-*-*-*-*-*-*' \
    -f '-gohu-gohufont-bold-r-normal--14-*-*-*-*-*-*-*' \
    -f "Font Awesome" | bash &

sleep 1
stalonetray &
