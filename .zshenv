#------------------------------------
# ヒストリの設定
#------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

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

# machine local config loading
ZSH_LOCAL_ENV_CONFIG_FILE=$HOME/.zshenv.local
[[ -e $ZSH_LOCAL_ENV_CONFIG_FILE ]] && source $ZSH_LOCAL_ENV_CONFIG_FILE

# 単語区切りの指定
# default: *?_-.[]~=/&;!#$%^(){}<>
export WORDCHARS="*?[]~;!$%^(){}<>"
