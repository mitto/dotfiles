#!/bin/sh

dotfiles=( .zshrc .tmux.conf .screenrc .vimrc .hgrc .hgignore_global )

for file in ${dotfiles[@]}
do
  if [ -e $HOME/$file ]; then
    mv $HOME/$file $HOME/$file.bak
  fi

  ln -s $HOME/dotfiles/$file $HOME/$file
done
