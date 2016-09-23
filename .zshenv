
#------------------------------------
# 言語周りの設定
#------------------------------------
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

#------------------------------------
# ヒストリの設定
#------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

#------------------------------------
# その他
#------------------------------------

export EDITOR=vim
export WORDCHARS="*?[]~;!$%^(){}<>" # default: *?_-.[]~=/&;!#$%^(){}<>


#--------------------------------------------------------
# ls color setting for bsd
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
export LSCOLORS=gxfxcxdxbxegedabagacad # for bsd ls


#--------------------------------------------------------
# ls color setting for bsd
# - https://www.gfd-dennou.org/arch/morikawa/memo/ls_colors.txt
# - https://linuxjm.osdn.jp/html/LDP_man-pages/man5/dir_colors.5.html
#--------------------------------------------------------
## ファイル種別
# NORMAL 0 (ファイル名でない) 通常のテキスト
# FILE 0 通常のファイル
# DIR  32  ディレクトリ
# LINK 36  シンボリックリンク
# ORPHAN undefined 孤立したシンボリックリンク
# MISSING  undefined 行方不明のファイル
# FIFO 31  名前付きパイプ (FIFO)
# SOCK 33  ソケット
# BLK  44;37 ブロックデバイス
# CHR  44;37 キャラクターデバイス
# EXEC 35  実行ファイル
#
## 色について(ISO 6429)
# 0  デフォルトカラーを復元
# 1  より明るい色
# 4  下線付きのテキスト
# 5  点滅するテキスト
# 30 文字表示色：黒
# 31 文字表示色：赤
# 32 文字表示色：緑
# 33 文字表示色：黄 (または茶)
# 34 文字表示色：青
# 35 文字表示色：紫
# 36 文字表示色：シアン
# 37 文字表示色：白 (またはグレー)
# 40 背景色：黒
# 41 背景色：赤
# 42 背景色：緑
# 43 背景色：黄 (または茶)
# 44 背景色：青
# 45 背景色：紫
# 46 背景色：シアン
# 47 背景色：白 (またはグレー)
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

#------------------------------------
# パスの設定
#------------------------------------
## 重複したパスを登録しない。
typeset -U path

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。

export GOPATH=$HOME/.go

## for zplug
case ${OSTYPE} in
  darwin*)
    export ZPLUG_HOME=/usr/local/opt/zplug
    ;;
  *)
    export ZPLUG_HOME=~/.zplug
    ;;
esac

[[ -e $HOME/.rbenv ]] && export PATH=$HOME/.rbenv/bin:$PATH

# machine local config loading
ZSH_LOCAL_ENV_CONFIG_FILE=$HOME/.zshenv.local
[[ -e $ZSH_LOCAL_ENV_CONFIG_FILE ]] && source $ZSH_LOCAL_ENV_CONFIG_FILE
