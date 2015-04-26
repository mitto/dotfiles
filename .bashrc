# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions

POWERLINE_SCRIPT=$HOME/dotfiles/.vim/bundle/powerline/powerline/bindings/bash/powerline.sh
[ -f $POWERLINE_SCRIPT ] && source $POWERLINE_SCRIPT

source $HOME/dotfiles/shell.d/initializer.sh
source $HOME/dotfiles/shell.d/alias.sh
source $HOME/dotfiles/shell.d/complete.sh
