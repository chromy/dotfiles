" Some parts stolen from Gary Bernhardt's .vimrc

call pathogen#infect()

" set runtimepath=~/.vim,$VIMRUNTIME

set number

set colorcolumn=80

set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set hlsearch

" Tmp files go in one place
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" display incomplete commands
set showcmd

" Colors
set t_Co=256 " 256 colors
set background=dark
color Tomorrow-Night

" Enable syntax highlighting
syntax enable
" Turn on something to do with compleation.
filetype plugin indent on

" change leader to ,
let mapleader = ","

" m -> make
nmap <Leader>m :w\|:!make<cr>

" b -> run
nmap <Leader>b :w\|:! ./%<cr>

" n -> test
nmap <Leader>n :w\|:!make test<cr>

" Show end of line white space
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red

function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>

