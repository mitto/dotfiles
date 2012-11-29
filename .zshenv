#====================================
# 環境変数の設定
#====================================

#文字コードの設定
export LANG=ja_JP.UTF-8

#------------------------------------
# lsの色設定
#
# 参考にしたところ
# - http://d.hatena.ne.jp/edvakf/20080413/1208042916
# - http://news.mynavi.jp/column/zsh/009/index.html
#------------------------------------
# a: 黒
# b: 赤
# c: 緑
# d: 茶
# e: 青
# f: マゼンタ
# g: シアン
# h: 白
# A: 黒(太字)
# B: 赤(太字)
# C: 緑(太字)
# D: 茶(太字)
# E: 青(太字)
# F: マゼンタ(太字)
# G: シアン(太字)
# H: 白(太字)
# x: デフォルト色
export LSCOLORS=gxfxcxdxbxegedabagacad

#------------------------------------
# エディタ関連の環境変数設定
#------------------------------------
export EDITOR=vim
# rubyの補完で使うrsenseのPATHを指定
export RSENSE_HOME=$HOME/opt/rsense-0.3

#------------------------------------
# ヒストリの設定
#------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

#------------------------------------
# OSごとに必要なパスを追加
#------------------------------------
case ${OSTYPE} in
  darwin*)
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    export PATH="/usr/local/Cellar/ruby/1.9.3-p327/bin:$PATH"
    export PATH="$PATH:/usr/local/share/python"
    ;;
  *)
    ;;
esac

# 各OSで共通なパスを追加
export PATH="$PATH:$HOME/bin"

# rbenvのパスを追加
if [ -e $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pythonzのパスを追加
if [ -e $HOME/.pythonz ]; then
  [[ -s $HOME/.pythonz/etc/bashrc ]] && source $HOME/.pythonz/etc/bashrc
  export PATH=$HOME/.pythonz/pythons/CPython-2.7.3/bin:$PATH
fi
