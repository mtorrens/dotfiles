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
# Configuration for other programs

# I don't want a history for less
export LESSHISTFILE=-

# Disable mail checking and resource-fork copying, only on OS X
if [ `uname -s` = "Darwin" ]; then
  export MAILPATH=""
  export COPYFILE_DISABLE=true
fi

# Find Cabal package directory if it's available
if [ -d "$HOME/Library/Haskell/bin" ]; then
  export PATH="$HOME/Library/Haskell/bin:$PATH"
fi


###############################################################################
# Aliases for daily use

# Set up the directory colors, either GNU or BSD style depending on
# whether or not dircolors is available.
if [ type -P dircolors &> /dev/null ]; then
  eval `dircolors -b`
  alias ls='ls --color=auto'
else
  export LSCOLORS="ExGxFxdaCxDaDaabagCxCx"
  alias ls='ls -G'
fi
alias grep='grep --color=auto'

# Read man pages in Skim
manp() { man -t "${1}" | ps2pdf - - | open -f -a Skim ; }
alias man='manp'

# Some random aliases
alias quit=exit

# This is the magic sauce for my dotfiles configuration
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# Dropbox: find all "conflicts", which just show up in the filesystem
alias db-conflicts='cd Dropbox && find -L . \( -path "*.dropbox*" -prune \) -o \( -name "*conflicted*" -print \)'

# Alias for YUI Compressor
alias yuicomp='java -jar ~/bin/yuicompressor-2.4.6.jar'

# Alias for setting a development shell
alias devshell="export PS1='[\[\e[31;1m\]\u@\h\[\e[0m\] \w]\$ \[\e]2;\u@\h:\w\a\]' && export PATH='/usr/local/dev/bin:/usr/local/dev/sbin:$PATH' && export DYLD_LIBRARY_PATH='/usr/local/dev/lib' && export PKG_CONFIG_PATH='/usr/local/dev/lib/pkgconfig:$PKG_CONFIG_PATH'"

