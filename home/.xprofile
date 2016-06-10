#!/bin/sh

# fix broken $UID on some system...
if test "x$UID" = "x"; then
  if test -x /usr/xpg4/bin/id; then
    UID=`/usr/xpg4/bin/id -u`;
  else
    UID=`id -u`;
  fi
fi

# set $XDG_MENU_PREFIX to "xfce-" so that "xfce-applications.menu" is picked
# over "applications.menu" in all Xfce applications.
if test "x$XDG_MENU_PREFIX" = "x"; then
  XDG_MENU_PREFIX="xfce-"
  export XDG_MENU_PREFIX
fi

# set DESKTOP_SESSION so that one can detect easily if an Xfce session is running
if test "x$DESKTOP_SESSION" = "x"; then
  DESKTOP_SESSION="xfce"
  export DESKTOP_SESSION
fi

# set XDG_CURRENT_DESKTOP so that Qt 5 applications can identify user set Xfce theme
if test "x$XDG_CURRENT_DESKTOP" = "x"; then
  XDG_CURRENT_DESKTOP="XFCE"
  export XDG_CURRENT_DESKTOP
fi

# $XDG_CONFIG_HOME defines the base directory relative to which user specific
# configuration files should be stored. If $XDG_CONFIG_HOME is either not set
# or empty, a default equal to $HOME/.config should be used.
if test "x$XDG_CONFIG_HOME" = "x" ; then
  XDG_CONFIG_HOME=$HOME/.config
fi
[ -d "$XDG_CONFIG_HOME" ] || mkdir "$XDG_CONFIG_HOME"

# $XDG_CACHE_HOME defines the base directory relative to which user specific
# non-essential data files should be stored. If $XDG_CACHE_HOME is either not
# set or empty, a default equal to $HOME/.cache should be used.
if test "x$XDG_CACHE_HOME" = "x" ; then
  XDG_CACHE_HOME=$HOME/.cache
fi
[ -d "$XDG_CACHE_HOME" ] || mkdir "$XDG_CACHE_HOME"

# set up XDG user directores.  see
# http://freedesktop.org/wiki/Software/xdg-user-dirs
if which xdg-user-dirs-update >/dev/null 2>&1; then
    xdg-user-dirs-update
fi

# Modify libglade and glade environment variables so that
# it will find the files installed by Xfce
GLADE_CATALOG_PATH="$GLADE_CATALOG_PATH:"
GLADE_PIXMAP_PATH="$GLADE_PIXMAP_PATH:"
GLADE_MODULE_PATH="$GLADE_MODULE_PATH:"
export GLADE_CATALOG_PATH
export GLADE_PIXMAP_PATH
export GLADE_MODULE_PATH

# For now, start with an empty list
XRESOURCES=""

# Has to go prior to merging Xft.xrdb, as its the "Defaults" file
test -r "/etc/xdg/xfce4/Xft.xrdb" && XRESOURCES="$XRESOURCES /etc/xdg/xfce4/Xft.xrdb"
test -r $HOME/.Xdefaults && XRESOURCES="$XRESOURCES $HOME/.Xdefaults"

BASEDIR=$XDG_CONFIG_HOME/xfce4
if test -r "$BASEDIR/Xft.xrdb"; then
  XRESOURCES="$XRESOURCES $BASEDIR/Xft.xrdb"
elif test -r "$XFCE4HOME/Xft.xrdb"; then
  mkdir -p "$BASEDIR"
  cp "$XFCE4HOME/Xft.xrdb" "$BASEDIR"/
  XRESOURCES="$XRESOURCES $BASEDIR/Xft.xrdb"
fi

# merge in X cursor settings
test -r "$BASEDIR/Xcursor.xrdb" && XRESOURCES="$XRESOURCES $BASEDIR/Xcursor.xrdb"

# ~/.Xresources contains overrides to the above
test -r "$HOME/.Xresources" && XRESOURCES="$XRESOURCES $HOME/.Xresources"

# Load the distribution defaults for xinitrcs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# load all X resources (adds /dev/null to avoid an empty list that would hang the process)
cat /dev/null $XRESOURCES | xrdb -nocpp -merge -

# load local modmap
test -r $HOME/.Xmodmap && xmodmap $HOME/.Xmodmap

# Go path needs to be set in every app in X
export GOPATH=$HOME/Development/go

# GPG agent is being run locally
unset SSH_AGENT_PID
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

# Silliness for QT4 to find GTK icon theme
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Silliness for QT5 to have configurable themes at all (!?)
# export QT_STYLE_OVERRIDE=gtk

# Fix ugly Java apps
export _JAVA_OPTIONS="-Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=lcd -Dswing.aatext=true"

# Fix ugly QT5 apps
export QT_STYLE_OVERRIDE="GTK+"

# Configure Infinality
# export INFINALITY_FT_FILTER_PARAMS="11 22 38 22 11"
# export INFINALITY_FT_GRAYSCALE_FILTER_STRENGTH="25"
# export INFINALITY_FT_FRINGE_FILTER_STRENGTH="0"
# export INFINALITY_FT_AUTOHINT_HORIZONTAL_STEM_DARKEN_STRENGTH="10"
# export INFINALITY_FT_AUTOHINT_VERTICAL_STEM_DARKEN_STRENGTH="25"
# export INFINALITY_FT_WINDOWS_STYLE_SHARPENING_STRENGTH="0"
# export INFINALITY_FT_CHROMEOS_STYLE_SHARPENING_STRENGTH="0"
# export INFINALITY_FT_STEM_ALIGNMENT_STRENGTH="0"
# export INFINALITY_FT_STEM_FITTING_STRENGTH="0"
# export INFINALITY_FT_GAMMA_CORRECTION="0 100"
# export INFINALITY_FT_BRIGHTNESS="0"
# export INFINALITY_FT_CONTRAST="0"
# export INFINALITY_FT_USE_VARIOUS_TWEAKS="osx"
# export INFINALITY_FT_AUTOHINT_INCREASE_GLYPH_HEIGHTS="true"
# export INFINALITY_FT_AUTOHINT_SNAP_STEM_HEIGHT="100"
# export INFINALITY_FT_STEM_SNAPPING_SLIDING_SCALE="40"
# export INFINALITY_FT_USE_KNOWN_SETTINGS_ON_SELECTED_FONTS="true"

# check if we start xfce4-session with ck-launch-session. this is only
# required for starting from a console, not a login manager
if test "x$XFCE4_SESSION_WITH_CK" = "x1"; then
  if which ck-launch-session >/dev/null 2>&1; then
    ck-launch-session xfce4-session
  else
    echo
    echo "You have tried to start Xfce with consolekit support, but"
    echo "ck-launch-session is not installed."
    echo "Aborted startup..."
    echo

    exit 1
  fi
else
  # start xfce4-session normally
  xfce4-session
fi
