au!
execute pathogen#infect()
execute pathogen#helptags()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CORE EDITING SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
colorscheme delek
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set cindent " replacing smartindent because of some weird stuff with # symbols
set laststatus=2
set backspace=indent,eol,start
set number
set laststatus=2
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set cmdheight=1
set switchbuf=useopen
set colorcolumn=80
set shell=bash
set scrolloff=3
set showcmd
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set nofoldenable
syntax on
filetype plugin on
filetype indent on

" Turn backup off
set nobackup
set nowb
set noswapfile
highlight Search cterm=NONE ctermfg=white  ctermbg=red
set whichwrap+=<,>,h,l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS (on write)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufWritePre * :%s/\s\+$//e  " trim trailing whitespace
au BufWritePre * :retab        " convert tabs to spaces


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Slime
let g:slime_python_ipython = 1
let g:slime_default_config = {"sessionname": "repl", "windowname": "0"}


" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_autoclose_preview_window_after_completion=1
highlight Pmenu ctermfg=2 ctermbg=17


" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_checkers = ['flake8', 'pep8']
let g:syntastic_python_checker_args="--ignore=E501,W601"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-airline
let g:airline_powerline_fonts = 0
function! AirlineInit()
" disable those wonky arrows - the don't look right without special fonts
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_section_warning = airline#section#create(['syntastic'])
"let g:airline_section_y = ''  " don't care about encoding
endfunction
au VimEnter * if exists(':AirlineToggle') | call AirlineInit()

" vim-cljfmt
let g:clj_fmt_autosave = 1

" vim-rainbow-parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
" write then run
au Filetype python nmap <c-p> :w \| !python % \| more<cr>
" Define the current compiler
if exists("compiler")
finish
endif
let compiler = "python"

" Set python as the make program and
setlocal makeprg=python
setlocal errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" When writing Python file check the syntax
autocmd BufWritePost *.py call Flake8()

autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

" Clojure
au Filetype clojure nmap <c-r> :w \| !lein exec % \| more<cr>
au Filetype clojure let g:clojure_fuzzy_indent = 1
au Filetype clojure let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']
au Filetype clojure set tabstop=2
au BufNewFile,BufRead *.clj set filetype=clojure
function! TestToplevel() abort
    "Eval the toplevel clojure form (a deftest) and then test-var the
    "result."
    normal! ^
    let line1 = searchpair('(','',')', 'bcrn', g:fireplace#skip)
    let line2 = searchpair('(','',')', 'rn', g:fireplace#skip)
    let expr = join(getline(line1, line2), "\n")
    let var = fireplace#session_eval(expr)
    let result = fireplace#echo_session_eval("(clojure.test/test-var " . var . ")")
    return result
endfunction
au Filetype clojure nmap <c-c><c-t> :call TestToplevel()<cr>


