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

source $HOME/dotfiles/shell.d/initializer.sh
source $HOME/dotfiles/shell.d/alias.sh
source $HOME/dotfiles/shell.d/complete.sh
