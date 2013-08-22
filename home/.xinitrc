#!/bin/bash

# Merge my Xresources
xrdb -merge $HOME/.Xresources

# Set up my keyboard
setxkbmap -option ctrl:nocaps

# Drop screen brightness on boot
echo "908" > /sys/class/backlight/intel_backlight/brightness

# Set the right DPI
xrandr --dpi 135

# Load the system xinitrc (PulseAudio, DBus)
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


# Silliness for QT4
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Start Gnome-Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# Notification daemon
dunst &

# Set background
nitrogen --restore &


# System tray
bbpager &
lal &
docker &

# Battery monitor
batti &

# Disk mounter (the environment variable makes it find the icons)
DESKTOP_SESSION=gnome yaudtray &

# Kupfer
kupfer --no-splash &

# Shift color temperature of display at night
redshift &

# Update checker
kalu &

# Personal Wiki
[[ -d $HOME/Dropbox/Charles/Wiki ]] && cd $HOME/Dropbox/Charles/Wiki && rake server &


# Run OpenBox
exec openbox-session


# Kill the PulseAudio daemon
pulseaudio -k
