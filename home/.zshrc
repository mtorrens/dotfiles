
###############################################################################
# Basic shell settings

# Set the console color theme, if available
if [[ -e $HOME/bin/color-theme ]]; then
  . $HOME/bin/color-theme
fi

# Load some things that ZSH doesn't by default
autoload zmv

# Configure history file
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Shell options
setopt APPEND_HISTORY
setopt AUTO_CD
unsetopt BEEP
setopt COMPLETE_IN_WORD
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt IGNORE_EOF
setopt INC_APPEND_HISTORY
unsetopt NOTIFY
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt SHARE_HISTORY

# Oh My Zsh
if [[ -d /usr/share/oh-my-zsh ]]; then
  ZSH=/usr/share/oh-my-zsh
fi
if [[ -d $HOME/.oh-my-zsh ]]; then
  ZSH=$HOME/.oh-my-zsh
fi

if [[ ! -z "$ZSH" ]]; then
  ZSH_THEME="gentoo"
  DISABLE_AUTO_UPDATE="true"
  DISABLE_CORRECTION="true"
  plugins=(archlinux git bundler colored-man gem rake rbenv)
  source $ZSH/oh-my-zsh.sh

  # Except for this.  Don't do this.
  unalias 1 2 3 4 5 6 7 8 9 spec
fi

###############################################################################
# Path settings

# TeX: pick up OS X TeXLive binary path
if [ -d /usr/local/texbin ]; then
  export PATH="/usr/local/texbin:$PATH"
fi

# Haskell Platform: find cabal binaries if installed
if [ -d $HOME/.cabal ]; then
  export PATH="$HOME/.cabal/bin:$PATH"
fi

# Always let home-directory binaries override everything
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

###############################################################################
# Configuration for other programs/systems

LANG=en_US.UTF-8
EDITOR=nano
LESSHISTFILE=-

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

# JRuby configuration (ONCE JRUBY 1.7.5 IS RELEASED, THIS SHOULD NOT BE NECESSARY!!)
export JRUBY_OPTS="-Xcompile.invokedynamic=false"

###############################################################################
# Colorize all the things
GRC=`which grc`

if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
  alias colorify='grc -es --colour=auto'
  alias configure='colorify ./configure'
  alias cvs='colorify cvs'
  alias diff='colorify diff'
  alias dig='colorify dig'
  alias gcc='colorify gcc'
  alias g++='colorify g++'
  alias as='colorify as'
  alias ld='colorify ld'
  alias ifconfig='colorify ifconfig'
  alias mount='colorify mount'
  alias netstat='colorify netstat'
  alias ping='colorify ping'
  alias ps='colorify ps'
  alias traceroute='colorify traceroute'
fi

###############################################################################
# Aliases for daily use

alias quit=exit

# Sort by version (which is awesome) and show type indicators
alias ls='ls -F --sort=version --color=auto '
alias ll='ls -Fl --sort=version --color=auto '
alias la='ls -FlA --sort=version --color=auto '

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

# Dropbox: find all "conflicts", which just show up in the filesystem
alias db-conflicts='find -L ~/Dropbox \( -path "*.dropbox*" -prune \) -o \( -name "*conflicted*" -print \)'

# Development directories
dev() { cd ~/Development/$1; }
devm() { cd ~/Development/$1/master; }
_dev() { _files -W ~/Development -/; }
compdef _dev dev
compdef _dev devm

devp() { subl3 --project ~/Development/$1/$1.sublime-project }
_devp() { _files -W ~/Development -/; }
compdef _devp devp

# Fast Dropbox access
db() { cd ~/Dropbox/Charles/$1; }
_db() { _files -W ~/Dropbox/Charles -/; }
compdef _db db
