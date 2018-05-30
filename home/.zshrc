
###############################################################################
# Basic shell settings

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
if [[ -f /usr/share/oh-my-zsh/oh-my-zsh.sh ]]; then
  ZSH=/usr/share/oh-my-zsh
else
  echo 'Cannot find oh-my-zsh; please install oh-my-zsh-git package ASAP'
fi

if [[ ! -z "$ZSH" ]]; then
  ZSH_THEME="gentoo"
  CASE_SENSITIVE="true"
  DISABLE_AUTO_UPDATE="true"
  DISABLE_CORRECTION="true"
  RBENV_ROOT="$HOME/.rbenv"
  PERLBREW_ROOT="$HOME/.perl5"

  ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
  if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
  fi

  plugins=(git colored-man gem rake rbenv golang systemd virtualbox)
  source $ZSH/oh-my-zsh.sh

  # Except for this.  Don't do this.
  unalias 1 2 3 4 5 6 7 8 9
fi

# zsh key bindings for urxvt
bindkey "\e[7~" beginning-of-line
bindkey "\e[1~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[4~" end-of-line

# Don't get the enter key confused
stty icrnl

###############################################################################
# Path settings

# Go path
export GOPATH="$HOME/Development/go"
export PATH="$PATH:$GOPATH/bin"

# NPM path
export NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# Always let home-directory binaries override everything
if [ -d $HOME/bin ]; then
  export PATH="$HOME/bin:$PATH"
fi

###############################################################################
# Configuration for other programs/systems

LANG=en_US.UTF-8
EDITOR=/usr/bin/nano
VISUAL=/usr/bin/nano
BROWSER=/usr/bin/chromium
LESSHISTFILE=-

###############################################################################
# Colorize all the things

if [ "$TERM" != dumb ]; then
  alias dmesg='dmesg -L'
  alias grep='grep --color=auto'
  alias egrep='egrep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias less='less --RAW-CONTROL-CHARS'
fi

###############################################################################
# Aliases for daily use

# Aliases for using yay for package management
alias pacin='yay -S'
alias pacins='yay -U'
alias pacrem='yay -Rns'
alias pacupg='yay -Syu --devel'
alias pacclean='yay -Yc'

# Sort by version (which is awesome) and show type indicators
alias l='ls --file-type --sort=version --color=auto '
alias ls='ls --file-type --sort=version --color=auto '
alias ll='ls -lh --file-type --sort=version --color=auto '
alias la='ls -lhA --file-type --sort=version --color=auto '

# Customize ps output
alias ps='ps axf'
alias pgrep='pgrep -a'

# Customize MPC output
export MPC_FORMAT='%artist% - %title% (##%track%: %album%)'

# Find broken symlinks
find-broken() {
  find $1 -xtype l
}

# Binary diff
bindiff() {
  diff -y <(xxd $1) <(xxd $2) | colordiff
}

# Development directories
dev() { cd ~/Development/$1; }
devm() { cd ~/Development/$1/master; }
_dev() { _files -W ~/Development -/; }
compdef _dev dev
compdef _dev devm

devg() { cd ~/Development/go/src/$1; }
_devg() { _files -/ -W ~/Development/go/src; }
compdef _devg devg

devp() { subl3 --project ~/Development/$1/$1.sublime-project }
_devp() { _files -W ~/Development -/; }
compdef _devp devp

alias subp='subl3 `ls *.sublime-workspace`'

# Completion for a variety of my scripts
compdef '_files -g "*.md"' pandoc-slides
compdef '_files -g "*.md"' pandoc-print

# Rage quit support
function fuck() {
  if killall -9 "$2"; then
    echo ; echo " (╯°□°）╯︵$(echo "$2"|flip)"; echo
  fi
}
