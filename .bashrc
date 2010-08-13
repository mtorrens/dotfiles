#!/bin/bash
# Bash configuration

###############################################################################
# Bash Configuration

# Get MacPorts' bash-completion
if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
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

# Set up the directory colors
eval $(gdircolors -b)
alias ls='gls --color=auto'
alias grep='grep --color=auto'

# Some random aliases
alias quit=exit
alias blosxom="~/bin/blosxom/blosxom -password='staticpass'"

# This is a fancy alias to make sure that cabal install is used globally.
# FIXME: What other Cabal commands will need to be prefixed like this?  Any?
cabal() { if [[ $1 == "install" ]]; then shift; command sudo cabal install --global $@; else command cabal $@; fi; }

# This is the magic sauce for my dotfiles configuration
alias config='git --git-dir=$HOME/.config.git/ --work-tree=$HOME'


###############################################################################
# Aliases for all the coreutils that are installed by MacPorts

# I used to install these without the 'g' prefix, but that leads to bizarre
# breakage in build systems which see OS X and expect the BSD, not the GNU
# behavior for their utilities ('basename' was a killer for this).

alias basename=gbasename
alias cat=gcat
alias cp=gcp
alias cut=gcut
alias date=gdate
alias dd=gdd
alias dir=gdir
alias dirname=gdirname
alias head=ghead
#already did ls=gls
alias make=gmake
alias mkdir=gmkdir
alias mv=gmv
alias pwd=gpwd
alias rmdir=grmdir
alias sed=gsed
alias sort=gsort
alias tail=gtail
alias tar=gnutar
