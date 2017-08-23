#!/bin/sh
# Let the screen turn off

# Enable monitor power saving modes
xset +dpms

# Kill any processes hanging around that are keeping the locker from activating
killall light-locker-command
