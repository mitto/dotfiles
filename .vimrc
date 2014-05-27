"NeoBundleで管理しているプラグインを読み込む
source ~/dotfiles/.vimrc.bundle

"基本的な設定の読み込み
source ~/dotfiles/.vimrc.basic

"エンコーディング周りの設定
source ~/dotfiles/.vimrc.encoding

"インデント周りの設定
source ~/dotfiles/.vimrc.indent

"検索周りの設定
source ~/dotfiles/.vimrc.search

"ステータスライン周りの設定
source ~/dotfiles/.vimrc.statusline

"プラグイン周りの設定
source ~/dotfiles/.vimrc.plugins_setting

"ローカル設定の読み込み
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
