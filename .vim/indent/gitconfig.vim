if exists('b:did_indent')
  finish
endif

setlocal autoindent

setlocal noexpandtab
setlocal tabstop=2

let b:undo_indent = 'setlocal '.join([
\   'autoindent<',
\   'expandtab<',
\   'tabstop<',
\ ])

let b:did_indent = 1
