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
# grepの設定
#------------------------------------
## GNU grepがあったら優先して使う。
if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi
## grepのバージョンを検出。
grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)[^0-9.]*$/\1/')"
## デフォルトオプションの設定
export GREP_OPTIONS
### バイナリファイルにはマッチさせない。
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
### 拡張子が.tmpのファイルは無視する。
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
## 管理用ディレクトリを無視する。
if grep --help 2>&1 | grep -q -- --exclude-dir; then
    GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi
### 可能なら色を付ける。
if grep --help 2>&1 | grep -q -- --color; then
    GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi


#------------------------------------
# パスの設定
#------------------------------------
## 重複したパスを登録しない。
typeset -U path
## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。

source $HOME/dotfiles/shell.d/initializer.sh
