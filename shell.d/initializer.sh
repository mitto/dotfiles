#!/bin/bash

PATH=$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# rbenv initialize
[[ -e $HOME/.rbenv ]] && eval "$(rbenv init -)"

export PATH

export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

export EDITOR=vim

#--------------------------------------------------------
# ls color setting
# - http://d.hatena.ne.jp/edvakf/20080413/1208042916
# - http://news.mynavi.jp/column/zsh/009/index.html
#--------------------------------------------------------
# colors..
#   a: black b: red c: green d: brown
#   e: blue f: magenta g: cyan h: white
#   A-H: bold colors x: default
#
# details...
#       Type               Foreground Background
# 1,2   Directory          blue       (default)
# 3,4   Symlink            magenta    (default)
# 5,6   Socket             green      (default)
# 7,8   Pipe               brown      (default)
# 9,10  Executable         red        (default)
# 11,12 Block              blue       cyan
# 13,14 Character          blue       brown
# 15,16 Exec. w/ SUID      black      red
# 17,18 Exec. w/ SGID      black      cyan
# 19,20 Dir, o+w, sticky   black      green
# 21,22 Dir, o+w, unsticky black      brown
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS=$LSCOLORS
