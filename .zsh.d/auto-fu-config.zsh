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
