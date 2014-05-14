# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

alias ls="ls --color=auto"
alias ll="ls -la"

alias gitw="GIT_SSH=$HOME/.ssh/git-wrap.sh git"
