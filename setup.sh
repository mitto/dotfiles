#!/bin/bash

function create-folder () {
  local folder_path=$1
  if [ ! -e $folder_path ]; then
    echo create bin folder : $folder_path
    mkdir $folder_path
  fi
}

function create-symlink () {
  local src_path=$HOME/dotfiles/$1
  local dst_path=$HOME/$1
  if [ -e $dst_path -a ! -L $dst_path ]; then
    echo "backup file : $dst_path"
    mv $dst_path $dst_path.bak
  fi

  if [ ! -L $dst_path ]; then
    echo "new symbolic link : $dst_path"
    ln -s $src_path $dst_path
  fi
}

dotfiles=( .zshrc .zshenv .tmux.conf .screenrc .vimrc .gemrc .gitconfig .gitignore_global .hgrc .hgignore_global )

for file in ${dotfiles[@]}
do
  create-symlink $file
done

create-folder $HOME/bin

case ${OSTYPE} in
  darwin*)
    create-symlink .brewfile
    ;;
esac
