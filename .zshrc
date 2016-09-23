# use emacs key binding
bindkey -e

## functions
function update-diff-highlight () {
  local latest_url=https://raw.githubusercontent.com/git/git/master/contrib/diff-highlight/diff-highlight
  local bin_dir=$HOME/bin
  local bin=$bin_dir/diff-highlight
  [ ! -e $bin_dir ] && mkdir $bin_dir
  echo Download latest diff-highlight
  curl $latest_url -o $bin
  echo Set Execute Permission
  chmod +x $bin
  echo diff-highlight update is Done
}

## configure command aliases
case ${OSTYPE} in
  darwin*)
    alias ls="ls -AGF"
    alias apc="screen /dev/tty.usbserial 2400"
    alias cisco="screen /dev/tty.usbserial 9600"
    alias buffalo="screen /dev/tty.usbserial 19200"
    alias edgemax="screen /dev/tty.usbserial 115200"
    ;;
  *)
    alias ls="ls -AF --color=auto"
    ;;
esac

alias g="git"
alias gitw="GIT_SSH=$HOME/dotfiles/other/git-wrap.sh git"
alias t="tmux"
alias ti="tig"

alias v="vim"

alias l="ls -laF"
alias ll="l"
alias h="anyframe-widget-put-history"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias be="bundle exec"

## configure environment variables
export PATH=$HOME/.rbenv/bin:$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# rbenv initialize
[[ -e $HOME/.rbenv ]] && eval "$(rbenv init -)"

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
export LSCOLORS=gxfxcxdxbxegedabagacad # for bsd ls

export GOPATH=$HOME/.go

## configure plugins
#
### for zplug
case ${OSTYPE} in
  darwin*)
    export ZPLUG_HOME=/usr/local/opt/zplug
    ;;
  *)
    export ZPLUG_HOME=~/.zplug
    ;;
esac
source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions", use:src
zplug "hchbaw/auto-fu.zsh", at:pu
zplug "mollifier/anyframe"
zplug "felixr/docker-zsh-completion"
zplug "wakeful/zsh-packer"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose


## initialize powerline for zsh
which powerline-config 2>&1 > /dev/null
ret=$?
if [ $ret -eq 0 ]; then
  export POWERLINE_STATUS_ROOT_PATH="$(pip show powerline-status | grep Location | awk '{ print $2 }')"
  . $POWERLINE_STATUS_ROOT_PATH/powerline/bindings/zsh/powerline.zsh
fi

# anyframe
zstyle ":anyframe:selector:" use peco
zstyle ":anyframe:selector:peco:" command 'peco --initial-filter SmartCase'

bindkey '^x^b' anyframe-widget-checkout-git-branch

bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

# docker-zsh-completion
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# some autoload setting
autoload -Uz colors && colors
autoload history-search-end
autoload -Uz is-at-least    # zshのバージョンチェック用関数を使えるようにする

# precmdに対してhookを簡単に登録できるようにする
# - http://d.hatena.ne.jp/kiririmode/20120327/p1
autoload -Uz add-zsh-hook

setopt interactive_comments # # 以降をコメントとして扱う
setopt transient_rprompt    # コマンド実行後は右プロンプトを消す

setopt auto_cd             # ディレクトリ名のみで移動できるようにする
setopt auto_pushd          # 移動したディレクトリを自動でpushdしてくれる
setopt pushd_ignore_dups   # 重複したディレクトリをpushdしない
setopt correct             # コマンドのミスタイプを訂正するか聞いてくれる
setopt auto_resume         # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt ignore_eof          # ^D でシェルを終了しない

setopt share_history        # 他のシェルのコマンド履歴を共有する
setopt append_history       # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt hist_ignore_dups     # 直前と同じコマンドはヒストリに残さない
setopt hist_ignore_all_dups # 重諷するコマンドが記録されるとき古い方を削除する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt hist_save_no_dups    # ヒストリファイルに書き出すとき古いコマンドと同じ物を無視する
setopt extended_history     # ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する
setopt inc_append_history   # すぐにヒストリファイルに追記する。

# set completion options

setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt list_packed             # 補完候補のリストをなるべく詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
setopt magic_equal_subst       # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できるようにする
setopt auto_param_keys         # カッコの対応などを自動的に補完する
setopt auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_remove_slash       # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
setopt nolistbeep              # 補完時のビープを止める
setopt brace_ccl               #  {a-c} を a b c に展開する機能を使えるようにする
setopt list_packed             # aliasを補完候補に含める
setopt complete_in_word        # カーソル位置で補完する。
setopt globdots                # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt glob_complete           # globを展開しないで候補の一覧から補完する。
setopt extended_glob           # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt hist_expand             # 補完時にヒストリを自動的に展開する。
setopt no_beep                 # 補完候補がないときなどにビープ音を鳴らさない。
#setopt numeric_glob_sort       # 辞書順ではなく数字順に並べる。

#==================================================
# for completion
#==================================================

# select completer
zstyle ':completion:*' completer _expand _complete _correct _ignored _prefix

zstyle ':completion:*:default' menu select=2        # 補完候補を矢印キーなどで選択できるようにする
zstyle ':completion:*:default' list-colors ""       # 補完候補に色を付ける（空文字列はデフォルト値を使うという意味）

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' group-name ''                # 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%d%b'              # %B...%b: 「...」を太字にする。 %d: 補完方法のラベル

zstyle ':completion::expand:*' glob true            # echo /bin/*sh とかで展開する
zstyle ':completion::expand:*' substitute true      # echo $(ls) とかで展開する

# 誤りの許容数を指定する
zstyle ':completion:*approximate:*' max-errors 2 NUMERIC

bindkey "\e[Z" reverse-menu-complete                # Shift-Tabで補完候補を逆順する

# for awscli
which aws 2>&1 > /dev/null
ret=$?
[ $ret -eq 0 ] && . /usr/local/bin/aws_zsh_completer.sh

#------------------------------------------------------------
# 文字入力時にURLをエスケープする
#------------------------------------------------------------
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#------------------------------------------------------------
# コマンド履歴検索の設定
# - http://news.mynavi.jp/column/zsh/004/index.html
#
# コマンドの入力途中でCtrl+Pを入力すると入力履歴から
# 該当する物を順次表示する
#------------------------------------------------------------
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# enable compinit
autoload -U compinit && compinit -u

## machine local config loading
ZSH_LOCAL_CONFIG_FILE=$HOME/.zshrc.local
[[ -e $ZSH_LOCAL_CONFIG_FILE ]] && source $ZSH_LOCAL_CONFIG_FILE

[[ -z $DISABLE_AUTO_FU_COMPLETION ]] && source $HOME/dotfiles/.zsh.d/auto-fu-config.zsh
