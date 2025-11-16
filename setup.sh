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

dotfiles=( .zshrc .zshenv .tmux.conf .screenrc .vimrc .gemrc .gitconfig .gitignore_global )

for file in ${dotfiles[@]}
do
  create-symlink $file
done

case ${OSTYPE} in
  darwin*)
    create-symlink .brewfile
    ;;
  linux*)
    git clone https://github.com/nodenv/nodenv.git $HOME/.nodenv || cd $HOME/.nodenv && git pull
    git clone https://github.com/nodenv/node-build.git $HOME/.nodenv/plugins/node-build || cd $HOME/.nodenv/plugins/node-build && git pull
    git clone --depth=1 https://github.com/tfutils/tfenv.git $HOME/.tfenv || cd $HOME/.tfenv && git pull
    ;;
esac

# Check if terraform-ls is installed
if ! which terraform-ls > /dev/null 2>&1; then
  echo "=========================================="
  echo "WARNING: terraform-ls is not installed!"
  echo "Please install terraform-ls for Terraform LSP support."
  echo ""
  echo "Installation guide:"
  echo "  https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md"
  echo ""
  echo "macOS: brew install terraform-ls"
  echo "Other: go install github.com/hashicorp/terraform-ls@latest"
  echo "=========================================="
fi

create-folder $HOME/bin
create-folder $HOME/.rbenv/plugins

RBENV_DEFAULT_GEMS_PATH=$HOME/.rbenv/plugins/rbenv-default-gems
[ ! -e $RBENV_DEFAULT_GEMS_PATH ] && git clone https://github.com/rbenv/rbenv-default-gems.git $RBENV_DEFAULT_GEMS_PATH

create-symlink .rbenv/default-gems
