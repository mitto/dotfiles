#!/bin/sh

dotfiles=( .zshrc .tmux.conf .screenrc .vimrc .vim .hgrc .hgignore_global )

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
  echo created vim backup folder : $HOME/.vim/.backup
  mkdir $HOME/.vim/.backup
fi

if [ ! -e $HOME/.vim/.swap ]; then
  echo created vim swap folder : $HOME/.vim/.swap
  mkdir $HOME/.vim/.swap
fi


