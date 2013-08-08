#!/bin/sh

# Merge my Xresources
xrdb -merge $HOME/.Xresources

# Set the right DPI
xrandr --dpi 135

# Load the system xinitrc (PulseAudio, DBus)
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Start Gnome-Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# NetworkManager
nm-applet &

# Dropbox
dropboxd &


# Run WindowMaker
exec wmaker


# Kill the PulseAudio daemon
pulseaudio -k
