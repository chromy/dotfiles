set nocp

execute pathogen#infect()

syntax on
filetype plugin indent on

" Set up tabs widths.
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
autocmd Filetype html setlocal ts=8 sts=0 sw=2
autocmd Filetype javascript setlocal ts=8 sts=0 sw=2

" Show 80 chars.
set colorcolumn=81

" Show tabs and spaces at the end of the line.
set list
set listchars=tab:▸▸,trail:·

" Nice search.
set incsearch
set ignorecase
set smartcase
set hlsearch

" Turn on col/row numbers.
set ruler
set number

" Change leader to ,
let mapleader = ","

" Colorscheme.
set background=dark
colorscheme Tomorrow-Night

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

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  let dict = { 'buf': bufnr('%'), 'vim_command': a:vim_command, 'temps': { 'result': tempname() }, 'name': 'SelectaCommand' }

  function! dict.on_exit(id, code)
    bd!

    if a:code != 0
      return 1
    endif

    if filereadable(self.temps.result)
      let l:selection = readfile(self.temps.result)[0]

      exec self.vim_command." ".l:selection
    else
      echom "selecta: error: can't read selection from (".self.temps.result.")"
    endif
  endfunction

  if a:vim_command != ':e'
    exec 'split '.dict.buf
  endif

  call termopen(a:choice_command." | selecta ".a:selecta_args." > ".dict.temps.result, dict)

  setf dict
  startinsert
endfunction

nnoremap <leader>p :call SelectaCommand("selecta-command", "", ":e")<cr>
" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

" Map leader, space to kill white space.
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

