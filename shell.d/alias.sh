#!/bin/sh

case ${OSTYPE} in
  darwin*)
    alias ls='ls -G'
    alias idm='wine ~/Dropbox/idm/IDM.exe'
    alias cisco='screen /dev/tty.usbserial 9600'
    ;;
  *)
    alias ls='ls --color=auto'
    ;;
esac

alias gitw="GIT_SSH=$HOME/dotfiles/other/git-wrap.sh git"

alias vi='vim'
alias nvim="vim -u NONE -N"

alias l='ls -laF'
alias ll='l'
