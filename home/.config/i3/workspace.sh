#!/bin/bash
# If we're on my desktop, with two monitors, make odd-numbered workspaces show
# up on the left monitor, and even-numbered workspaces show up on the right
# monitor.

num_displays=`xrandr --current | grep ' connected' | wc -l`
if [[ "$num_displays" -eq 1 ]]; then
  exit
fi

left_display_line=`xrandr --current | grep ' connected' | grep '+0+0'`
left_display=`echo $left_display_line | sed 's@\([^ ]*\) .*@\1@'`

right_display_line=`xrandr --current | grep ' connected' | grep -v '+0+0'`
right_display=`echo $right_display_line | sed 's@\([^ ]*\) .*@\1@'`

# Odd numbered workspaces to the left
i3-cmd workspace 1 output $left_display
i3-cmd workspace 3 output $left_display
i3-cmd workspace 5 output $left_display
i3-cmd workspace 7 output $left_display
i3-cmd workspace 9 output $left_display
i3-cmd workspace 11 output $left_display

# Even numbered workspaces to the right
i3-cmd workspace 2 output $right_display
i3-cmd workspace 4 output $right_display
i3-cmd workspace 6 output $right_display
i3-cmd workspace 8 output $right_display
i3-cmd workspace 10 output $right_display
i3-cmd workspace 12 output $right_display
