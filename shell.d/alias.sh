#!/bin/sh

case ${OSTYPE} in
  darwin*)
    alias ls='ls -AGF'
    alias apc='screen /dev/tty.usbserial 2400'
    alias cisco='screen /dev/tty.usbserial 9600'
    alias buffalo='screen /dev/tty.usbserial 19200'
    alias edgemax='screen /dev/tty.usbserial 115200'
    ;;
  *)
    alias ls='ls -AF --color=auto'
    ;;
esac

alias g="git"
alias gitw="GIT_SSH=$HOME/dotfiles/other/git-wrap.sh git"

alias vi='vim'
alias nvim="vim -u NONE -N"
alias svim="/usr/bin/vim"

alias l='ls -laF'
alias ll='l'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# grep
if type ggrep > /dev/null 2>&1; then
  alias grep=ggrep
fi

grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)[^0-9.]*$/\1/')"
export GREP_OPTIONS
GREP_OPTIONS="--binary-files=without-match"
case "$grep_version" in
    1.*|2.[0-4].*|2.5.[0-3])
  ;;
    *)
  ### grep 2.5.4以降のみの設定
  ### grep対象としてディレクトリを指定したらディレクトリ内を再帰的にgrepする。
  GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
  ;;
esac

GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"

if grep --help 2>&1 | grep -q -- --exclude-dir; then
  GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
  GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi

if grep --help 2>&1 | grep -q -- --color; then
  GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi
