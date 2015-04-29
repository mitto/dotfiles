bindkey -e

# some autoload setting
autoload -U compinit && compinit -u
autoload -Uz colors && colors
autoload history-search-end
autoload -Uz is-at-least    # zshのバージョンチェック用関数を使えるようにする

# precmdに対してhookを簡単に登録できるようにする
# - http://d.hatena.ne.jp/kiririmode/20120327/p1
autoload -Uz add-zsh-hook

setopt auto_cd             # ディレクトリ名のみで移動できるようにする
setopt auto_pushd          # 移動したディレクトリを自動でpushdしてくれる
setopt correct             # コマンドのミスタイプを訂正するか聞いてくれる
setopt auto_resume         # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする

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
zstyle ':completion:*' completer _expand _complete _approximate _ignored _prefix

zstyle ':completion:*:default' menu select=2        # 補完候補を矢印キーなどで選択できるようにする
zstyle ':completion:*:default' list-colors ""       # 補完候補に色を付ける（空文字列はデフォルト値を使うという意味）

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*' group-name ''                # 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%d%b'              # %B...%b: 「...」を太字にする。 %d: 補完方法のラベル

# 誤りの許容数を指定する
zstyle ':completion:*approximate:*' max-errors 2 NUMERIC

bindkey "\e[Z" reverse-menu-complete                # Shift-Tabで補完候補を逆順する

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

# http://izawa.hatenablog.jp/entry/2012/09/18/220106
preexec() {
  mycmd=(${(s: :)${1}})
  echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$mycmd[1]\e\\"
}

precmd() {
  echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):idle\e\\"
}

#==================================================
# etc..
#==================================================
() {
  # for antigen.zsh
  local ANTIGEN_SOURCE=$HOME/dotfiles/.zsh.d/antigen/antigen.zsh

  if [ -e $ANTIGEN_SOURCE ]; then
    source $ANTIGEN_SOURCE
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-completions src
    antigen bundle hchbaw/auto-fu.zsh --branch=pu
    antigen apply
  fi
}

() {
  # initialize powerline for zsh
  local ZSH_POWERLINE=$HOME/dotfiles/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh
  [[ -e $ZSH_POWERLINE ]] && source $ZSH_POWERLINE
}

# for auto-fu config and functions
() {
  # for auto-fu precompile
  local S=$HOME/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-hchbaw-SLASH-auto-fu.zsh.git-PIPE-pu/auto-fu.zsh
  local D=$HOME/dotfiles/.zsh.d/auto-fu.zsh
  [[ -e "${D:r}.zwc" ]] && [[ "$S" -ot "${D:r}.zwc" ]] ||
    zsh -c "source $S; auto-fu-zcompile $D ${D:h}" >/dev/null 2>&1
  source ${D:r}; auto-fu-install

  # for auto-fu style
  zstyle ':auto-fu:highlight' input bold
  zstyle ':auto-fu:highlight' completion fg=black,bold
  zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
  zstyle ':auto-fu:var' postdisplay $'\n-auto-fu-'
  zstyle ':auto-fu:var' track-keymap-skip opp
  zle-line-init () {auto-fu-init;}; zle -N zle-line-init
  zle -N zle-keymap-select auto-fu-zle-keymap-select
}

# for auto-fu fix can't escape cancel
# http://d.hatena.ne.jp/tarao/comment/20100531
function afu+cancel () {
  afu-clearing-maybe
  ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
}

function bindkey-advice-before () {
  local key="$1"
  local advice="$2"
  local widget="$3"
  [[ -z "$widget" ]] && {
    local -a bind
    bind=(`bindkey -M main "$key"`)
    widget=$bind[2]
  }
  local fun="$advice"
  if [[ "$widget" != "undefined-key" ]]; then
    local code=${"$(<=(cat <<"EOT"
      function $advice-$widget () {
        zle $advice
        zle $widget
      }
      fun="$advice-$widget"
EOT
    ))"}
    eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
  fi
  zle -N "$fun"
  bindkey -M afu "$key" "$fun"
}

#bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-line

# machine local config loading
ZSH_LOCAL_CONFIG_FILE=$HOME/.zshrc.local
[[ -e $ZSH_LOCAL_CONFIG_FILE ]] && source $ZSH_LOCAL_CONFIG_FILE
