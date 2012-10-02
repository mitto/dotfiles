#====================================
# 環境変数の設定
#====================================

export LANG=ja_JP.UTF-8
export EDITOR=vim

#パスの設定
case ${OSTYPE} in
  darwin*)
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    export PATH="$PATH:/usr/local/share/python"
    export PATH="$PATH:/Users/mitto/bin"
    ;;
  *)
    ;;
esac
export LSCOLORS=gxfxcxdxbxegedabagacad

#====================================
# コマンドエイリアス
#====================================
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

alias vi='vim'
alias sudo='sudo '
alias l='ls -laF'
alias ll='l'


#====================================
# zsh オプション
#====================================
autoload -Uz add-zsh-hook
autoload -Uz colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
  zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
  zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg

setopt auto_cd             # ディレクトリ名のみで移動できるようにする
setopt auto_pushd          # 移動したディレクトリを自動でpushdしてくれる
setopt correct             # コマンドのミスタイプを訂正するか聞いてくれる
setopt list_packed         # 補完候補のリストをなるべく詰めて表示する
setopt list_types          # 補完候補にファイルの種類も表示する
setopt magic_equal_subst   # =以降も補完するようにする

setopt nolistbeep          # たぶん候補変換完了時にビジュアルビープ出さないようにする

setopt auto_resume         # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit; compinit # 補完機能を有効にする

#zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
#                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
#                             /usr/local/git/bin
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt auto_param_keys         # カッコの対応などを自動的に補完する
setopt auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_remove_slash       # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
setopt magic_equal_subst       # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt brace_ccl               #  {a-c} を a b c に展開する機能を使えるようにする
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

bindkey -e   #Emacsキーバインドにする

#====================================
# ヒストリの設定
#====================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt append_history       # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt hist_ignore_dups     # 直前と同じコマンドはヒストリに残さない
setopt share_history        # 他のシェルのコマンド履歴を共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#====================================
# プロンプトの設定
#------------------------------------
# 色一覧
#------------------------------------
# 00: なにもしない
# 01: 太字化
# 04: 下線
# 05: 点滅
# 07: 前背色反転
# 08: 表示しない
# 22: ノーマル化
# 24: 下線なし
# 25: 点滅なし
# 27: 前背色反転なし
# 30: 黒(前景色)
# 31: 赤(前景色)
# 32: 緑(前景色)
# 33: 茶(前景色)
# 34: 青(前景色)
# 35: マゼンタ(前景色)
# 36: シアン(前景色)
# 37: 白(前景色)
# 39: デフォルト(前景色)
# 40: 黒(背景色)
# 41: 赤(背景色)
# 42: 緑(背景色)
# 43: 茶(背景色)
# 44: 青(背景色)
# 45: マゼンタ(背景色)
# 46: シアン(背景色)
# 47: 白(背景色)
# 49: デフォルト(背景色)
#------------------------------------
# プロンプト表示フォーマット
#------------------------------------
# %% %を表示
# %) )を表示
# %l 端末名省略形
# %M ホスト名(FQDN)
# %m ホスト名(サブドメイン)
# %n ユーザー名
# %y 端末名
# %# rootなら#、他は%を表示
# %? 直前に実行したコマンドの結果コード
# %d ワーキングディレクトリ %/ でも可
# %~ ホームディレクトリからのパス
# %h ヒストリ番号 %! でも可
# %a The observed action, i.e. "logged on" or "logged off".
# %S (%s) 反転モードの開始/終了 %S abc %s とするとabcが反転
# %U (%u) 下線モードの開始/終了 %U abc %u とするとabcに下線
# %B (%b) 強調モードの開始/終了 %B abc %b とするとabcを強調
# %t 時刻表示(12時間単位、午前/午後つき) %@ でも可
# %T 時刻表示(24時間表示)
# %* 時刻表示(24時間表示秒付き)
# %w 日表示(dd) 日本語だと 曜日 日
# %W 年月日表示(mm/dd/yy)
# %D 年月日表示(yy-mm-dd)
#====================================
case ${UID} in
0)
    PROMPT="%{[31m%}%/%{[m%} %# "
    PROMPT2="%{[31m%}%/%{[m%} %# "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%} %b "
    RPROMPT="%1(v|%F{green}%1v%f|)"
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="%{[$[32+$RANDOM % 5]m%}%/%{[m%} %# "
    PROMPT2="%{[31m%}%/%{[m%} %# "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    RPROMPT="%1(v|%F{green}%1v%f|)"
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac
