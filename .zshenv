#====================================
# 環境変数の設定
#====================================

#文字コードの設定
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

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

#------------------------------------
# ヒストリの設定
#------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

#------------------------------------
# OSごとに必要なパスを追加
#------------------------------------

## 重複したパスを登録しない。
typeset -U path
## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。
path=(/bin(N-/)
  /sbin(N-/)
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /usr/local/share/python(N-/)
  /usr/bin(N-/)
  /usr/sbin(N-/)
  $HOME/.rbenv/bin(N-/)
  $HOME/bin(N-/)
)

if [ -e $HOME/.rbenv ]; then
  eval "$(rbenv init -)"
fi
