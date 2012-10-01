"------------------------------------------
"基本的な設定
"------------------------------------------
"vi互換モードを切る
"コマンド補完とかが使えるようになる
set nocompatible

"256色対応にする
set t_Co=256

"コマンドライン補完を拡張モードにする
set wildmenu

"改行コードの自動認識
set fileformats=unix,dos,mac

"バックスペースキーで削除できるものを指定
"indent  : 行頭の空白
"eol     : 改行
"start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

"コマンドと検索パターンの履歴保持数を設定
set history=100

"バッファを切替えてもundoの効力を失わない
set hidden

"起動時のメッセージを表示しない
set shortmess+=I

" 特定のキーに行頭および行末の回りこみ移動を許可する設定
"  b - [Backspace]  ノーマルモード ビジュアルモード
"  s - [Space]      ノーマルモード ビジュアルモード
"  < - [←]          ノーマルモード ビジュアルモード
"  > - [→]          ノーマルモード ビジュアルモード
"  [ - [←]          挿入モード 置換モード
"  ] - [→]          挿入モード 置換モード
"  ~ - ~            ノーマルモード
set whichwrap=b,s,[,],<,>,~,h,l

"------------------------------------------
"バックアップ関連
"------------------------------------------
"ファイルのバックアップをとっておくか
"set backup
set nobackup

"ファイルの上書き前にバックアップを作るか(backupをオンにしておかない場合は上書き成功後削除される)
set writebackup
set backupcopy=yes

"バックアップディレクトリ
"set backupdir=~/.backup

"スワップファイルのディレクトリ
"set directory=~/.swap

"------------------------------------------
"表示関連
"------------------------------------------
"自動的に行番号を表示する
set number

"タブや改行について表示する
set list

"不可視文字を可視化する
"eol:文字 論理行の行末に表示する文字を指定、省略した場合は何も表示されない
"tab:2文字 タブ文字の最初の桁の文字と次の桁以降に表示する２文字を指定、省略した場合「^|」が表示される
"trail:文字 行末の連続する空白文字を表示する文字を指定、省略した場合は何も表示されない
"nbsp:文字 改行不可な空白文字(0xA0,160)、一般的な空白(0x20 32)ではないため注意
"set listchars=

"全角スペースの表示
scriptencoding utf-8

augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

"highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
"match ZenkakuSpace /　/

"括弧入力時に対応する括弧を表示
set showmatch

"ルーラーの表示
set ruler

"ステータスラインの設定
set laststatus=2
set statusline=%F%m%r%h%w\ [%Y][%{&fenc}][%{&ff}]%=[行位置=%p%%][行サイズ=%L][位置=%04l,%04v]

set noerrorbells
set novisualbell
"set visualbell t_vb=

"------------------------------------------
"インデント関連
"------------------------------------------
"自動インデント
set autoindent
set smartindent

"タブ文字を入力した際に自動でホワイトスペースに展開されるかどうかを設定
set expandtab

"タブ幅を設定
set tabstop<

"タブ文字を入力した際にタブ文字の代わりに挿入されるホワイトスペースの量を設定
set softtabstop=2

"autoindent時に挿入されるタブの幅を設定
set shiftwidth=2

"------------------------------------------
"検索関連
"------------------------------------------
"検索文字列に大文字が含まれていたら区別して検索
set smartcase

"検索文字列の大文字小文字を区別しない
set ignorecase

"インクリメンタルサーチを使う
set incsearch

"検索時に最後まで言ったら最初に戻る
set wrapscan

"------------------------------------------
"シンタックス周り
"------------------------------------------
"シンタックスハイライトの有効化
syntax on

"------------------------------------------
"文字エンコード周り
"encoding: Vimが内部処理に試用するエンコーディング
"fileencoding: 現在開いているファイルのエンコーディング
"fileencodings: Vimがファイルを開く際に試すエンコーディング群
"termencoding:
"端末のエンコーディング->通常は未設定でかまわない（端末エミュレータが固定のエンコーディングしか扱えない場合に内部エンコーディングと異なるエンコーディングを指定する場合に使用）
"fileencodings->encoding
"------------------------------------------
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932


"------------------------------------------
"マウス周りの設定
"------------------------------------------
set mouse=a
set ttymouse=xterm2

"------------------------------------------
"その他
"------------------------------------------
set nf=alpha,hex

set virtualedit=block

"最後の編集位置にカーソルを自動的に移動させる
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"挿入モードをステータスラインの色で把握できるようにする
"au InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
"au InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray gui=none ctermfg=Blue ctermbg=DarkGray cterm=none

"------------------------------------------
"zen-coding周り
"------------------------------------------
let g:user_zen_settings = {
\	'lang' : 'ja',
\}
"let g:user_zen_leader_key = '<c><Space>'

"------------------------------------------
"neocomplcache周り
"------------------------------------------
"Insert mode補完の設定を行います。’,'区切りでmenuone, menu, preview, longestを指定できます。
"初期値は”menu,preview”です。
"menu ポップアップメニューを使った補完を有効にします。
"menuone 補完候補が一つしかなくてもポップアップメニューを表示します。補完候補の情報を見るのに便利です。
"longest マッチする一番長いテキストのみ補完します。<C-l>を使うことで、補完する文字を増やすことができます。大文字・小文字の区別がどうなるかは、補完に依存します。
"preview 補完関数が対応していれば、プレビューウインドウに追加情報を表示します。'completeopt'にmenuかmenuoneがないと動作しません。この処理は一部の補完関数でしか有効にならず、しかも重いです。
" http://vim-users.jp/2009/05/hack9/
set completeopt=menuone

let g:neocomplcache_enable_at_startup = 1 "起動時に有効化
let g:neocomplcache_enable_smart_case = 1 "大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_camel_case_completion = 1 "camel caseは大文字を区切りとしたワイルドカードのように振る舞う
let g:neocomplcache_enable_underbar_completion = 1 "アンダーバー区切り補完を有効化
"let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_min_syntax_length = 3 "シンタックスをキャッシュするときの最小文字長
"let g:neocomplcache_max_list = 20 "補完候補の表示個数を指定
" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"

"------------------------------------------
"project.vim
"------------------------------------------
"プロジェクトのトグル開閉
nmap <silent> <Leader>P <Plug>ToggleProject
"デフォルトのプロジェクトを開く
nmap <silent> <Leader>p :Project<CR>

"------------------------------------------
"buftabs.vim
"------------------------------------------
"ファイル名だけ表示
let buftabs_only_basename = 1
"ステータスラインに表示
"let buftabs_in_statusline = 1

"------------------------------------------
"bufexplorer.vim
"------------------------------------------
"ヘルプを常に表示
"let bufExplorerDetailedHelp = 1

"------------------------------------------
"RSense
"------------------------------------------

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:rsenseUseOmniFunc = 1
if filereadable(expand('~/opt/rsense-0.3/bin/rsense'))
  let g:rsenseHome = expand('~/opt/rsense-0.3')

  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif

"------------------------------------------
"vim-powerline
"------------------------------------------
set guifont=Monaco-Powerline.otf
let g:Powerline_symbols='fancy'

"------------------------------------------
"neobundle
"------------------------------------------
filetype off  

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

"completion plugin
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'taichouchou2/vim-rsense'

"syntax plugin
NeoBundle 'html5.vim'
NeoBundle 'nginx.vim'
NeoBundle 'glidenote/keepalived-syntax.vim'
NeoBundle 'petdance/vim-perl'
NeoBundle 'hail2u/vim-css3-syntax.git'
NeoBundle 'taichouchou2/vim-javascript'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'groenewege/vim-less'
NeoBundle 'JavaScript-syntax'
NeoBundle 'Syntastic'

"Indent plugin
NeoBundle 'pangloss/vim-javascript'

"document plugin
NeoBundle 'thinca/vim-ref'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'vim-jp/vimdoc-ja'

"develop plugin
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'ZenCoding.vim'
NeoBundle 'project.tar.gz'

"buffer plugin
NeoBundle 'bufexplorer.zip'

"color scheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'wombat256.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'jeffreyiacono/vim-colors-wombat'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/Lucius'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'mrkn/mrkn256.vim'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'tomasr/molokai'

"other plugin
NeoBundle 'sudo.vim'
NeoBundle 'sjl/gundo.vim.git'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'opsplorer'

NeoBundle 'koron/nyancat-vim'

filetype plugin indent on 

colorscheme wombat256mod
"colorscheme molokai
