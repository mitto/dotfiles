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

for file in `ls $HOME/dotfiles/.tmux.d`
do
  if [ ! -L $HOME/bin/$file ]; then
    echo "new symbolic link: $file"
    ln -s $HOME/dotfiles/.tmux.d/$file $HOME/bin/$file
  fi
done

if [ ! -e $HOME/opt/rubyref ]; then
  echo "start rubyref install"
  cd $HOME/opt
  wget "http://doc.ruby-lang.org/archives/201208/ruby-refm-1.9.3-dynamic-20120829.tar.gz" -O $HOME/opt/rubyref.tar.gz
  tar zxvf rubyref.tar.gz
  rm $HOME/opt/rubyref.tar.gz
  mv $HOME/opt/ruby-refm-1.9.3-dynamic-20120829 $HOME/opt/rubyref
fi

if [ ! -e $HOME/bin/refe ]; then
  echo "create refe commands"
  cat <<EOL > $HOME/bin/refe
#!/bin/sh
exec ruby -Ke -I ~/opt/rubyref/bitclust/lib ~/opt/rubyref/bitclust/bin/refe -d ~/opt/rubyref/db-1_9_3 "\$@"
EOL
  chmod 775 $HOME/bin/refe
  cd $HOME
fi
