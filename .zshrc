# use emacs key binding
bindkey -e

## configure command aliases
case ${OSTYPE} in
  darwin*)
    alias ls="ls -AGF"
    alias apc="screen /dev/tty.usbserial 2400"
    alias cisco="screen /dev/tty.usbserial 9600"
    alias buffalo="screen /dev/tty.usbserial 19200"
    alias edgemax="screen /dev/tty.usbserial 115200"
    alias python=/usr/local/bin/python3
    alias pip="pip3"
    ;;
  *)
    alias ls="ls -AF --color=auto"
    ;;
esac

alias g="git"
alias t="tmux"
alias ti="tig"

alias v="vim"

alias l="ls -laF"
alias ll="l"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias be="bundle exec"

alias mkd="mktemp -d"
alias cdt="cd $(mkd)"

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
setopt notify              # バックグラウンド処理の状態変化をすぐに通知する
setopt print_exit_value    # 終了ステータスが0以外の場合にステータスを表示する

setopt append_history       # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt hist_ignore_dups     # 直前と同じコマンドはヒストリに残さない
setopt hist_ignore_all_dups # 重諷するコマンドが記録されるとき古い方を削除する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt hist_save_no_dups    # ヒストリファイルに書き出すとき古いコマンドと同じ物を無視する
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
setopt print_eight_bit         # 日本語が文字化けしないように8bit文字を有効にする
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

## machine local config loading
ZSH_LOCAL_CONFIG_FILE=$HOME/.zshrc.local
[[ -e $ZSH_LOCAL_CONFIG_FILE ]] && source $ZSH_LOCAL_CONFIG_FILE

[[ -e $HOME/.rbenv ]] && eval "$(rbenv init - zsh)" # rbenv initialize
[[ -e $HOME/.nodenv ]] && eval "$(nodenv init - zsh)" # nodenv initialize

## initialize powerline for zsh/tmux
POWERLINE_ZSH_PATHS=(
  # Fedora/RHEL RPM
  "/usr/share/powerline/zsh/powerline.zsh"
  # pip --user
  "$HOME/.local/lib/python*/site-packages/powerline/bindings/zsh/powerline.zsh"
)

POWERLINE_TMUX_PATHS=(
  # Fedora/RHEL RPM
  "/usr/share/tmux/powerline.conf"
  # pip --user
  "$HOME/.local/lib/python*/site-packages/powerline/bindings/tmux/powerline.conf"
)

### pip経由でインストールされている場合のパス追加
if which powerline-config &> /dev/null; then
  PIP_ROOT="$(pip show powerline-status 2>/dev/null | grep Location | awk '{print $2}')/powerline"
  POWERLINE_ZSH_PATHS+=("$PIP_ROOT/bindings/zsh/powerline.zsh")
  POWERLINE_TMUX_PATHS+=("$PIP_ROOT/bindings/tmux/powerline.conf")
fi

### zsh用スクリプトを探してsource
for zsh_script in $POWERLINE_ZSH_PATHS; do
  if [[ -f "$zsh_script" ]]; then
    source "$zsh_script"
    break
  fi
done

### tmux用設定ファイルパスを探してexport
for tmux_conf in $POWERLINE_TMUX_PATHS; do
  if [[ -f "$tmux_conf" ]]; then
    export POWERLINE_TMUX_CONF="$tmux_conf"
    break
  fi
done

## initialize fzf searching
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

# enable compinit
autoload -U compinit && compinit -u
