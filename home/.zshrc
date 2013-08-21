
###############################################################################
# Basic shell settings

# Load required ZSH modules
autoload -Uz compinit promptinit colors

# Set the console color theme, if available
if [[ -e $HOME/bin/color-theme ]]; then
  . $HOME/bin/color-theme
fi

# Enable ZSH completion
compinit
zstyle :compinstall filename '~/.zshrc'

# Configure history file
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt appendhistory

# Set some random shell options
setopt autocd
unsetopt beep notify

bindkey -e

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

# Ruby: set up rbenv if installed
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Always let home-directory binaries override everything
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

###############################################################################
# Prompt

# Set the prompt
promptinit
colors

if [[ "$UID" == "0" ]]; then
    PROMPT="[%{$fg_bold[red]%}%m%{$reset_color%} %~]$ "
else
    PROMPT="[%{$fg_bold[green]%}%n@%m%{$reset_color%} %~]$ "
fi

###############################################################################
# Configuration for other programs/systems

LANG=en_US.UTF-8
EDITOR=/usr/bin/nano
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

###############################################################################
# Aliases for daily use

# Set up the directory colors, either GNU or BSD style depending on
# whether or not dircolors is available.  Also check for the GNU
# coreutils installed over Mac OS X with the g-prefix.
if type -p dircolors > /dev/null; then
  eval `dircolors -b`
  alias ls='ls --color=auto --sort=version'
elif type -p gdircolors > /dev/null; then
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

# Dropbox: find all "conflicts", which just show up in the filesystem
alias db-conflicts='find -L ~/Dropbox \( -path "*.dropbox*" -prune \) -o \( -name "*conflicted*" -print \)'
