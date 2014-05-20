# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions

case `uname` in
  Darwin*)
    alias ls="ls -G";;
  Linux*)
    alias ls="ls --color=auto";;
esac

alias ll="ls -la"

alias gitw="GIT_SSH=$HOME/.ssh/git-wrap.sh git"
