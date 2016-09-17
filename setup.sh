#!/bin/bash

dotfiles=( .zshrc .zshenv .tmux.conf .screenrc .vimrc .gemrc .gitconfig .gitignore_global .hgrc .hgignore_global )

for file in ${dotfiles[@]}
do
  if [ -e $HOME/$file -a ! -L $HOME/$file ]; then
    echo "backup file : ${file}"
    mv $HOME/$file $HOME/$file.bak
  fi

  if [ ! -L $HOME/$file ]; then
    echo "new symbolic link : ${file}"
    ln -s $HOME/dotfiles/$file $HOME/$file
  fi
done

if [ ! -e $HOME/bin ]; then
  echo create bin folder : $HOME/bin
  mkdir $HOME/bin
fi
