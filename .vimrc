" vim:set foldmethod=marker:

" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Flags
let s:use_dein = 1

" vi compatibility
if !&compatible
  set nocompatible
endif

" Prepare .vim dir
let s:vimdir = $HOME . "/dotfiles/.vim"
if has("vim_starting")
  if ! isdirectory(s:vimdir)
    call system("mkdir " . s:vimdir)
  endif
endif

" dein
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1

  " Set dein paths
  let s:dein_dir = s:vimdir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = "Shougo/dein.vim"
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

  " Check dein has been installed or not.
  if !isdirectory(s:dein_repo_dir)
    echo "dein is not installed, install now "
    let s:dein_repo = "https://github.com/" . s:dein_repo_name
    echo "git clone " . s:dein_repo . " " . s:dein_repo_dir
    call system("git clone " . s:dein_repo . " " . s:dein_repo_dir)
  endif
  let &runtimepath = &runtimepath . "," . s:dein_repo_dir

  " Check cache
  if dein#load_state(s:dein_dir)

    " Begin plugin part
    call dein#begin(s:dein_dir)

    " Plugin Manager
    call dein#add('Shougo/dein.vim')

    " Color Scheme
    call dein#add('vim-scripts/wombat256.vim')

    " Help Document
    call dein#add('vim-jp/vimdoc-ja')

    " Text Object
    call dein#add('kana/vim-textobj-datetime')
    call dein#add('kana/vim-textobj-diff')
    call dein#add('kana/vim-textobj-entire')
    call dein#add('kana/vim-textobj-fold')
    call dein#add('kana/vim-textobj-function')
    call dein#add('kana/vim-textobj-indent')
    call dein#add('kana/vim-textobj-jabraces')
    call dein#add('kana/vim-textobj-lastpat')
    call dein#add('kana/vim-textobj-line')
    call dein#add('kana/vim-textobj-syntax')
    call dein#add('kana/vim-textobj-user')
    call dein#add('rhysd/vim-textobj-ruby')

    " Library
    "" Asynchronous
    call dein#add('Shougo/vimproc', {'build': 'make'})

    " Completion
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    let g:deoplete#enable_at_startup = 1
    call dein#add('Shougo/neco-syntax')

    " Snippets
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('honza/vim-snippets')

    " Filer
    call dein#add('Shougo/vimfiler')

    " Indent Support
    call dein#add('nathanaelkane/vim-indent-guides')

    " Unite
    call dein#add('Shougo/unite.vim')

    " Code Execute
    call dein#add('thinca/vim-quickrun')

    " HTML Support
    call dein#add('mattn/emmet-vim')

    " Syntax Support
    call dein#add('stephpy/vim-yaml')
    call dein#add('vim-scripts/nginx.vim', {'on_ft' : 'nginx' })
    call dein#add('glidenote/keepalived-syntax.vim', {'on_ft' : 'keepalived'})
    call dein#add('elzr/vim-json')
    call dein#add('slim-template/vim-slim')
    call dein#add('scrooloose/syntastic')

    " Powerline Support
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " Git Support
    call dein#add('airblade/vim-gitgutter')
    call dein#add('tpope/vim-fugitive')

    " Input Support
    call dein#add('rhysd/accelerated-jk')
    call dein#add('kana/vim-smartinput')
    call dein#add('cohama/vim-smartinput-endwise')

    " Rails Support
    call dein#add('szw/vim-tags')
    call dein#add('tpope/vim-bundler')
    call dein#add('tpope/vim-rails')

    call dein#end()

    call dein#save_state()
  endif
endif

filetype plugin indent on
syntax enable

" Installation check.
if dein#check_install()
  call dein#install()
endif

"------------------------------------------
" basic configs
"------------------------------------------
colorscheme wombat256mod

"最後の編集位置にカーソルを自動的に移動させる
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

augroup highlightIdegraphicSpace
  autocmd!
  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

syntax on

"set visualbell t_vb=
set autoindent
set backspace=indent,eol,start
set backup
set backupcopy=yes
set backupdir=~/dotfiles/.vim/backup
set clipboard+=autoselect
set completeopt=menuone,preview
set cursorline
set directory=~/dotfiles/.vim/swap
set expandtab
set hidden
set history=100
set ignorecase
set incsearch
set laststatus=2
set list
set mouse=a
set noerrorbells
set novisualbell
set nrformats=alpha,hex
set number
set ruler
set shiftwidth=2
set shortmess+=I
set showmatch
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set tabstop<
set ttymouse=xterm2
set virtualedit=block
set whichwrap=b,s,[,],<,>,~,h,l
set wildmenu
set wrapscan
set writebackup

let g:netrw_dirhistmax = 0

if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

au BufNewFile,BufRead Schemafile setl ft=ruby " for ridgepole schemafile"

"------------------------------------------
"nginx.vim
"------------------------------------------
au BufRead,BufNewFile /etc/nginx/* setlocal ft=nginx

"------------------------------------------
"indent-guides
"------------------------------------------
" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラーを無効にする
let g:indent_guides_auto_colors=0
" 奇数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
" 偶数インデントのカラー
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=245
" ハイライト色の変化の幅
let g:indent_guides_color_change_percent = 30
" ガイドの幅
let g:indent_guides_guide_size = 2

"------------------------------------------
" neosnippet.vim
"------------------------------------------
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"------------------------------------------
" vim-json
"------------------------------------------
let g:vim_json_syntax_conceal = 0

"------------------------------------------
" vim-airline
"------------------------------------------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"------------------------------------------
" accelerated-jk
"------------------------------------------
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"------------------------------------------
" vim-smartinput-endwise
"------------------------------------------
call smartinput_endwise#define_default_rules()

"------------------------------------------
" syntastic
"------------------------------------------
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
