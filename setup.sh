#!/bin/bash

dotfiles=( .zprofile .zshrc .zshenv .zsh.d .tmux.conf .screenrc .vimrc .vim .hgrc .mercurial .gemrc )

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


if [ ! -e $HOME/.vim/.backup ]; then
  echo create vim backup folder : $HOME/.vim/.backup
  mkdir $HOME/.vim/.backup
fi

if [ ! -e $HOME/.vim/.swap ]; then
  echo create vim swap folder : $HOME/.vim/.swap
  mkdir $HOME/.vim/.swap
fi

if [ ! -e $HOME/bin ]; then
  echo create bin folder : $HOME/bin
  mkdir $HOME/bin
fi

if [ ! -e $HOME/opt ]; then
  echo create opt folder : $HOME/opt
  mkdir $HOME/opt
fi
