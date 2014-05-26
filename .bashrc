# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions

POWERLINE_SCRIPT=$HOME/dotfiles/.vim/bundle/powerline/powerline/bindings/bash/powerline.sh
[ -f $POWERLINE_SCRIPT ] && source $POWERLINE_SCRIPT

BASH_COMPLETION_SCRIPT=/usr/local/share/bash-completion/bash_completion
if [ -f $BASH_COMPLETION_SCRIPT ]; then
  source $BASH_COMPLETION_SCRIPT
fi

which aws && complete -C aws_completer aws

case `uname` in
  Darwin*)
    alias ls="ls -G";;
  Linux*)
    alias ls="ls --color=auto";;
esac

alias ll="ls -la"

alias gitw="GIT_SSH=$HOME/dotfiles/other/git-wrap.sh git"
alias nvim="vim -u NONE -N"
