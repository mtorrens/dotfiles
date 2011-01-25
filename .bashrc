#!/bin/bash
# Bash configuration

###############################################################################
# Bash Configuration

# Get bash-completion
if [ -f /usr/local/etc/bash_completion ]; then
	. /usr/local/etc/bash_completion
fi

# Set up the bash history
export HISTSIZE=4096
export HISTFILESIZE=16384

# Engage some shell options
shopt -s autocd
shopt -s checkjobs


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

# Disable mail checking by default on OS X
export MAILPATH=""

# Remove a worthless OS X "feature"
export COPYFILE_DISABLE=true


###############################################################################
# Aliases for daily use

# Set up the directory colors (BSD-style)
export LSCOLORS="ExGxFxdaCxDaDaabagCxCx"
alias ls='ls -G'
alias grep='grep --color=auto'

# Read man pages in Skim
manp() { man -t "${1}" | ps2pdf - - | open -f -a Skim ; }
alias man='manp'

# Some random aliases
alias quit=exit
alias openvnc="ssh -f -L 5900:localhost:5900 10.1.1.2 x11vnc -safer -localhost -nopw -once -xkb -display :0"

# This is the magic sauce for my dotfiles configuration
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

# This builds the static version of my website
alias poole="poole --md-ext=headerid --md-ext=tables --md-ext=def_list --ignore='^\.DS_Store|~$|\.ccss$' $HOME/Dropbox/Charles/Documents/Website"

# Configure Python virtualenv
export WORKON_HOME=~/Development/Python
source /usr/local/Cellar/python/2.7.1/bin/virtualenvwrapper.sh


