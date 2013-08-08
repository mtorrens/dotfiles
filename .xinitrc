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

# Silliness for QT4
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Start Gnome-Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

# Volume control
pasystray &

# NetworkManager
nm-applet &

# Dropbox
dropboxd &

# Disk mounter (the environment variable makes it find the icons)
DESKTOP_SESSION=gnome yaudtray &

# Shift color temperature of display at night
gtk-redshift

# Local web-app server
/opt/prax/bin/prax start


# Run WindowMaker
exec wmaker


# Kill the PulseAudio daemon
pulseaudio -k
