" Some parts stolen from Gary Bernhardt's .vimrc

call pathogen#infect()

set number

set colorcolumn=80
set expandtab
set tabstop=4
set shiftwidth=4
"autocmd FileType html :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files

" Turn off visual wrapping.
set nowrap

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

" Paste
"set clipboard=unnamed
"imap <D-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>
"imap <C-V> ^O"+p
"if &term =~ "xterm.*"
"    let &t_ti = &t_ti . "\e[?2004h"
"    let &t_te = "\e[?2004l" . &t_te
"    function XTermPasteBegin(ret)
"        set pastetoggle=<Esc>[201~
"        set paste
"        return a:ret
"    endfunction
"    map <expr> <Esc>[200~ XTermPasteBegin("i")
"    imap <expr> <Esc>[200~ XTermPasteBegin("")
"    cmap <Esc>[200~ <nop>
"    cmap <Esc>[201~ <nop>
"endif


" Colors
" set t_Co=256 " 256 colors
set background=dark
colorscheme Tomorrow-Night

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

" On copy and paste
"vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
" nmap <C-v> :call setreg("\"",system("pbpaste"))<CR>

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

if has("autocmd")
  au BufReadPost *.rkt,*.rktl set filetype=racket
  au filetype racket set lisp
  au filetype racket set autoindent
  au filetype racket set lisp
  au filetype racket RainbowParenthesesToggle
  au filetype racket RainbowParenthesesLoadRound
  au filetype racket RainbowParenthesesLoadSquare
  au filetype racket RainbowParenthesesLoadBraces
endif

set lispwords+=public-method,override-method,private-method,syntax-case,syntax-rules

function! PasteIntoLatex()
    let typo = {}
    let typo["“"] = "``"
    let typo["”"] = "''"
    let typo["‘"] = "`"
    let typo["’"] = "'"
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! PasteIntoLatex :call PasteIntoLatex()

function! RemoveFancyCharacters()
    let typo = {}
    let typo["“"] = '"'
    let typo["”"] = '"'
    let typo["‘"] = "'"
    let typo["’"] = "'"
    let typo["–"] = '--'
    let typo["—"] = '---'
    let typo["…"] = '...'
    :exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! RemoveFancyCharacters :call RemoveFancyCharacters()

function! WC()
    let filename = expand("%")
    let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
    let result = system(cmd)
    echo result . " words"
endfunction
command! WC call WC()

set backspace=indent,eol,start

inoremap jk <ESC>
