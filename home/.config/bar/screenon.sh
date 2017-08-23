#!/bin/sh
# Make sure the screen stays on

# Disable monitor power saving modes
xset -dpms

# Start a process that will keep the locker from activating
light-locker-command -i &
