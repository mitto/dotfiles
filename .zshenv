#pythonzの設定
if [ -e $HOME/.pythonz ]; then
  [[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc
  export PATH=$HOME/.pythonz/pythons/CPython-2.7.3/bin:$PATH
fi

export RSENSE_HOME=$HOME/opt/rsense-0.3
