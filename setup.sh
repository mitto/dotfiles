#!/bin/bash

function create-folder () {
  local folder_path=$1
  if [ ! -e $folder_path ]; then
    echo create bin folder : $folder_path
    mkdir -p $folder_path
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

case ${OSTYPE} in
  darwin*)
    create-symlink .brewfile
    ;;
esac

create-folder $HOME/bin
create-folder $HOME/.rbenv/plugins

RBENV_DEFAULT_GEMS_PATH=$HOME/.rbenv/plugins/rbenv-default-gems
[ ! -e $RBENV_DEFAULT_GEMS_PATH ] && git clone https://github.com/rbenv/rbenv-default-gems.git $RBENV_DEFAULT_GEMS_PATH

create-symlink .rbenv/default-gems
