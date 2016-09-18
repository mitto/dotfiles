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

function! s:meet_neocomplete_requirements()
  return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

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
    call dein#add('wombat256.vim')

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
    call dein#add('Shougo/neocomplete.vim')
    call dein#add('Shougo/neocomplcache.vim')

    if s:meet_neocomplete_requirements()
      call dein#config('neocomplcache.vim', {'lazy': 1})
    else
      call dein#config('neocomplete.vim', {'lazy': 1})
    endif

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
    call dein#add('nginx.vim', {'on_ft' : 'nginx' })
    call dein#add('glidenote/keepalived-syntax.vim', {'on_ft' : 'keepalived'})
    call dein#add('elzr/vim-json')
    call dein#add('slim-template/vim-slim')

    " Powerline Support
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " Git Support
    call dein#add('airblade/vim-gitgutter')
    call dein#add('tpope/vim-fugitive')

    " Input Support
    call dein#add('rhysd/accelerated-jk')
    call dein#add('kana/vim-smartinput')

    " Rails Support
    call dein#add('tpope/gem-ctags')
    call dein#add('tpope/vim-bundler')
    call dein#add('tpope/vim-rails')
    call dein#add('osyo-manga/vim-monster')

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

if s:meet_neocomplete_requirements()
  "------------------------------------------
  " neocomplete.vim
  "------------------------------------------
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  "let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
else

  "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Enable heavy features.
  " Use camel case completion.
  "let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  "let g:neocomplcache_enable_underbar_completion = 1

  " Define dictionary.
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplcache_enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplcache_enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplcache_enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplcache_enable_auto_select = 1
  "let g:neocomplcache_disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
  let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

  " For perlomni.vim setting.
  " https://github.com/c9s/perlomni.vim
  let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

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

"------------------------------------------
" accelerated-jk
"------------------------------------------
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"------------------------------------------
" vim-monster
"------------------------------------------
" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"
"
" Use neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
\   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
\}
