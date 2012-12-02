#!/bin/sh

dotfiles=( .zprofile .zshrc .zshenv .tmux.conf .screenrc .vimrc .vim .hgrc .hgignore_global .gemrc )

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

if [ ! -e $HOME/opt/rsense-0.3 ]; then
  echo Download rsense : http://cx4a.org/pub/rsense/rsense-0.3.zip
  curl http://cx4a.org/pub/rsense/rsense-0.3.zip > $HOME/opt/rsense-0.3.zip
  cd $HOME/opt
  echo Unzip rsense-0.3.zip file
  unzip rsense-0.3.zip
  echo Delete rsense-0.3.zip file
  rm rsense-0.3.zip
  chmod 744 rsense-0.3/bin/rsense
  cd $HOME
fi

if [ ! -e $HOME/.rsense ]; then
  echo Configure rsense
  ruby $HOME/opt/rsense-0.3/etc/config.rb > $HOME/.rsense
fi

for file in `ls $HOME/dotfiles/.tmux.d`
do
  if [ ! -L $HOME/bin/$file ]; then
    echo "new symbolic link: $file"
    ln -s $HOME/dotfiles/.tmux.d/$file $HOME/bin/$file
  fi
done
