#!/bin/bash
# Bash configuration

###############################################################################
# Bash Configuration

# Get bash-completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

# Set up the bash history
export HISTSIZE=4096
export HISTFILESIZE=16384

# Engage some shell options (quietly, in case they don't
# exist)
shopt -sq autocd
shopt -sq checkjobs


###############################################################################
# Path settings

# Python: pick up locally installed python executables
if [ -d /usr/local/share/python ]; then
  export PATH="/usr/local/share/python:$PATH"
fi

# TeX: pick up TeXLive binary path
if [ -d /usr/local/texbin ]; then
  export PATH="/usr/local/texbin:$PATH"
fi

# Haskell Platform: find cabal binaries if installed
if [ -d $HOME/.cabal ]; then
  export PATH="$HOME/.cabal/bin:$PATH"
fi

# Ruby: set up rbenv if installed
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Always let home-directory binaries override everything
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi


###############################################################################
# Prompt and Window Title

# Set the title bar
case "$TERM" in xterm*|rxvt*)
	PR_TITLEBAR="\[\e]2;\u@\h:\w\a\]"
	;;
*)
	PR_TITLEBAR=""
	;;
esac

# Set the prompt
if [[ "$UID" == "0" ]]; then
    PROMPT='[\[\e[31;1m\]\h\[\e[0m\] \w]\$ '
else
    PROMPT='[\[\e[32;1m\]\u@\h\[\e[0m\] \w]\$ '
fi

# And, set everything
export PS1="${PROMPT}${PR_TITLEBAR}"


###############################################################################
# Configuration for other programs/systems

export EDITOR=nano
export MAILDIR=$HOME/Dropbox/Charles/Mail/
export LESSHISTFILE=-

if [ `uname -s` = "Darwin" ]; then
  # Disable mail checking and resource-fork copying, only on OS X
  export MAILPATH=""
  export COPYFILE_DISABLE=true
elif [ `uname -o` = "Cygwin" ]; then
  # Set some environment variables on Windows
  export TMP=/tmp
  export TEMP=/tmp
  export TMPDIR=/tmp

  # Enable SSH authentication through Pageant
  if [ -z "$SSH_AUTH_SOCK" -a -x /usr/local/bin/ssh-pageant ]; then
    eval $(/usr/local/bin/ssh-pageant -q)
  fi
  trap logout HUP
fi


###############################################################################
# Aliases for daily use

# Set up the directory colors, either GNU or BSD style depending on
# whether or not dircolors is available.  Also check for the GNU
# coreutils installed over Mac OS X with the g-prefix.
if type -P dircolors > /dev/null; then
  eval `dircolors -b`
  alias ls='ls --color=auto --sort=version'
elif type -P gdircolors > /dev/null; then
  eval `gdircolors -b`
  alias ls='gls --color=auto --sort=version'
else
  export LSCOLORS="ExGxFxdaCxDaDaabagCxCx"
  alias ls='ls -G'
fi
alias grep='grep --color=auto'

# Some random aliases
alias quit=exit

# Alias the various ways to open documents in accord with their file
# associations
if command -v xdg-open >/dev/null 2>&1; then
  alias open=xdg-open
elif command -v exo-open >/dev/null 2>&1; then
  alias open=exo-open
elif command -v kde-open >/dev/null 2>&1; then
  alias open=kde-open
elif command -v gvfs-open >/dev/null 2>&1; then
  alias open=gvfs-open
elif command -v gnome-open >/dev/null 2>&1; then
  alias open=gnome-open
elif command -v cygstart >/dev/null 2>&1; then
  alias open=cygstart
fi
alias start=open

# This is the magic sauce for my dotfiles configuration
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'
alias confignwt='git --git-dir=$HOME/.config.git/'

# Bash timer
if command -v gdate >/dev/null 2>&1; then
  alias stopwatch='start=$(gdate +%s) watch -n1 '"'"'gdate --date=@$(($(gdate +%s) - start)) +%M:%S'"'"
else
  alias stopwatch='start=$(date +%s) watch -n1 '"'"'date --date=@$(($(date +%s) - start)) +%M:%S'"'"
fi

# Dropbox: find all "conflicts", which just show up in the filesystem
alias db-conflicts='find -L ~/Dropbox \( -path "*.dropbox*" -prune \) -o \( -name "*conflicted*" -print \)'
