#!/bin/bash

# Merge my Xresources
xrdb -merge $HOME/.Xresources

# Set up my keyboard
setxkbmap -option ctrl:nocaps

# Set the right DPI
xrandr --dpi 135

# Load the system xinitrc (PulseAudio, DBus)
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Make multimedia keys work with PulseAudio
for i in /dev/input/by-id/*-kbd; do
  pacmd load-module module-mmkbd-evdev device=$i &> /dev/null
done

# Silliness for QT4
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Start Gnome-Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# Notification daemon
/usr/lib/notification-daemon-1.0/notification-daemon &

# Volume control
pasystray &

# Battery monitor
batti &

# NetworkManager
nm-applet &

# Dropbox
dropboxd &

# Disk mounter (the environment variable makes it find the icons)
DESKTOP_SESSION=gnome yaudtray &

# Kupfer
kupfer --no-splash &

# Shift color temperature of display at night
redshift &

# Local web-app server
/opt/prax/bin/prax start &


# Run WindowMaker
exec wmaker


# Kill the PulseAudio daemon
pulseaudio -k
