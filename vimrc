" Some parts stolen from Gary Bernhardt's .vimrc

call pathogen#infect()

set number

set colorcolumn=80

set expandtab
set tabstop=4
set shiftwidth=4

set autoindent

" nice search
set incsearch
set ignorecase
set smartcase
set hlsearch

" This makes RVM work inside Vim. I have no idea why.
set shell=bash

" Tmp files go in one place
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" display incomplete commands
set showcmd

" Enable syntax highlighting
syntax enable
" Turn on something to do with compleation.
filetype plugin indent on

" change leader to ,
let mapleader = ","

let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>

" m -> make
nmap <Leader>m :w\|:!make<cr>

" b -> run
nmap <Leader>b :w\|:! ./%<cr>

" n -> test
nmap <Leader>n :w\|:!make test<cr>

imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>

" Colors
" set t_Co=256 " 256 colors
set background=dark
colorscheme solarized

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>    

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <Left> <Nop>
"map <Right> <Nop>
"map <Up> <Nop>
"map <Down> <Nop>

augroup vimrcEx
    autocmd!    

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
    
    " Show end of line white space
    autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
    autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
augroup END

highlight EOLWS ctermbg=red guibg=red

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to kill white space
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
