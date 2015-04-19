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

# loading alias config
source $HOME/dotfiles/shell.d/alias.sh

#====================================
# windowのタイトルを設定する
#
# 参考にしたところ
# - http://izawa.hatenablog.jp/entry/2012/09/18/220106
#
# preexec() コマンドを実行直前に呼び出される
# precmd()  プロンプトを表示直前に呼び出される
#====================================
#case "${TERM}" in
#kterm*|xterm*)
#    preexec() {
#        mycmd=(${(s: :)${1}})
#        echo -ne "\ek$mycmd[1]\e\\"
#    }
#    precmd() {
#        echo -ne "\ekidle\e\\"
#    }
#    ;;
#esac


#====================================
# zsh オプション
#====================================
source ~/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh

# キーバインドの設定
bindkey -e                 #Emacsキーバインドにする

setopt auto_cd             # ディレクトリ名のみで移動できるようにする
setopt auto_pushd          # 移動したディレクトリを自動でpushdしてくれる
setopt correct             # コマンドのミスタイプを訂正するか聞いてくれる
setopt auto_resume         # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする

# 補完周りの設定
# - http://voidy21.hatenablog.jp/entry/20090902/1251918174
fpath=($HOME/.zsh.d/zsh-completions/src $fpath)
autoload -U compinit; compinit # 補完機能を有効にする

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

bindkey "\e[Z" reverse-menu-complete                # Shift-Tabで補完候補を逆順する
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
zstyle ':completion:*:default' menu select=2        # 補完候補を矢印キーなどで選択できるようにする
zstyle ':completion:*:default' list-colors ""       # 補完候補に色を付ける（空文字列はデフォルト値を使うという意味）
zstyle ':completion:*' group-name ''                # 補完方法毎にグループ化する。
zstyle ':completion:*' format '%B%d%b'              # %B...%b: 「...」を太字にする。 %d: 補完方法のラベル
#zstyle ':completion:*' use-cache yes                # 補完候補をキャッシュする。
zstyle ':completion:*' verbose yes                  # 詳細な情報を使う。
setopt complete_in_word                             # カーソル位置で補完する。
setopt globdots                                     # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt glob_complete                                # globを展開しないで候補の一覧から補完する。
setopt extended_glob                                # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt hist_expand                                  # 補完時にヒストリを自動的に展開する。
setopt no_beep                                      # 補完候補がないときなどにビープ音を鳴らさない。
#setopt numeric_glob_sort                            # 辞書順ではなく数字順に並べる。

## 補完方法の設定。指定した順番に実行する。
#### _oldlist 前回の補完結果を再利用する。
#### _complete: 補完する。
#### _match: globを展開しないで候補の一覧から補完する。
#### _history: ヒストリのコマンドも補完候補とする。
#### _ignored: 補完候補にださないと指定したものも補完候補とする。
#### _approximate: 似ている補完候補も補完候補とする。
#### _prefix: カーソル以降を無視してカーソル位置までで補完する。
zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix

# sudo するときも補完が効くようにする
#zstyle ':completion:sudo:*' environ PATH = "$SUDO_PATH:$PATH"
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                                           /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
                                           /usr/local/git/bin

#----------------------------------------
# ヒストリ周りの設定
#----------------------------------------
setopt share_history        # 他のシェルのコマンド履歴を共有する
setopt append_history       # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt hist_ignore_dups     # 直前と同じコマンドはヒストリに残さない
setopt hist_ignore_all_dups # 重諷するコマンドが記録されるとき古い方を削除する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
setopt hist_save_no_dups    # ヒストリファイルに書き出すとき古いコマンドと同じ物を無視する
setopt extended_history     # ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する
setopt inc_append_history   # すぐにヒストリファイルに追記する。

#------------------------------------------------------------
# コマンド履歴検索の設定
# - http://news.mynavi.jp/column/zsh/004/index.html
#
# コマンドの入力途中でCtrl+Pを入力すると入力履歴から
# 該当する物を順次表示する
#------------------------------------------------------------
autoload history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# プロンプトでの色指定を名前でできるようにする
autoload -Uz colors
colors

autoload -Uz is-at-least    # zshのバージョンチェック用関数を使えるようにする

# precmdに対してhookを簡単に登録できるようにする
# - http://d.hatena.ne.jp/kiririmode/20120327/p1
autoload -Uz add-zsh-hook

#------------------------------------------------------------
# VCS周りの設定
# - http://mollifier.hatenablog.com/entry/20100906/p1
#------------------------------------------------------------
# formatで指定できる値について
#%s どのバージョン管理システムを使用しているかを表す（gitとかsvnに置き換えられる）
#%b ブランチ情報を表す
#%R リポジトリのルートディレクトリのパスを表す
#%r リポジトリ名を表す
#%S リポジトリのルートディレクトリから見た、今のディレクトリの相対パスを表す
#%c stagedstrを表す
#%u unstagedstrを表す
#------------------------------------------------------------
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true

if is-at-least 4.3.10; then
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"
    zstyle ':vcs_info:git:*' unstagedstr "-"
    zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'
fi

# vcs_infoのメッセージを更新する
function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# コマンドの実行前に上の関数を呼び出すためのフックを追加する
add-zsh-hook precmd _update_vcs_info_msg

# antigen.zsh setting
source ~/.zsh.d/antigen/antigen.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

## auto-fu.zsh
# precompiled source
function () { # precompile
    local A
    A=~/.zsh.d/auto-fu.zsh/auto-fu.zsh
    [[ -e "${A:r}.zwc" ]] && [[ "$A" -ot "${A:r}.zwc" ]] ||
    zsh -c "source $A; auto-fu-zcompile $A ${A:h}" >/dev/null 2>&1
}

source ~/.zsh.d/auto-fu.zsh/auto-fu && auto-fu-install
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=black,bold
zstyle ':auto-fu:highlight' completion/one fg=white,bold,underline
zstyle ':auto-fu:var' postdisplay $'\n-auto-fu-'
zstyle ':auto-fu:var' track-keymap-skip opp
zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zle -N zle-keymap-select auto-fu-zle-keymap-select


function () {
    local code
    code=${functions[auto-fu-init]/'\n-azfu-'/''}
    eval "function auto-fu-init () { $code }"
    code=${functions[auto-fu]/fg=black,bold/fg=white}
    eval "function auto-fu () { $code }"
}

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
bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-line

source $HOME/dotfiles/shell.d/alias.sh
source $HOME/dotfiles/shell.d/complete.sh

# 個別設定用
if [ -e $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
