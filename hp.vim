"
" Language:	Supervision Scripts Framework
" Licence:	Distributed under the same terms as Vim itself and/or 2-clause BSD
"
" Syntax highlighting for Supervision Scripts Framework by inheriting sh.vim.
" Requires vim 6.3 or later.
"

if &compatible || v:version < 603
    finish
endif

if exists("b:current_syntax")
    finish
endif

let is_bash=1
runtime! syntax/sh.vim
unlet b:current_syntax

syn keyword svKwd begin die end error eval_colors info yesno
syn keyword svKwd start_test start_pre start_post stop_pre stop_post
syn keyword svVars CONFDIR DEFAULT NULL PKG PROFILE PROFILES RUNDIR VERSION name

syn keyword svFunc start stop
syn cluster shCommandSubList add=svKwd

hi def link svKwd  Keyword
hi def link svFunc Special
hi def link svVars PreProc

let b:current_syntax = "hp"
