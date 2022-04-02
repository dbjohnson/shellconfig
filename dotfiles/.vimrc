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
highlight ColorColumn ctermbg=17
highlight Search cterm=NONE ctermfg=white  ctermbg=blue
highlight Error cterm=NONE ctermbg=darkred ctermfg=yellow
highlight SpellBad cterm=NONE ctermbg=darkred ctermfg=yellow
set whichwrap+=<,>,h,l

" clipboard integration
set clipboard=unnamed

" map f to grep for word under cursor
nnoremap f :grep! -r '\b<cword>\b' . <Bar> cw <CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Slime
let g:slime_python_ipython = 1
"let g:slime_target = "tmux"
"let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}
let g:slime_default_config = {"sessionname": "repl", "windowname": "0"}
""some keybindings don't work properly in a screen

" YouCompleteMe
let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_goto_buffer_command = 'new-or-existing-tab'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'
highlight Pmenu ctermfg=2 ctermbg=17
au Filetype python nmap <leader>d :YcmCompleter GoToDefinition<cr> 
au Filetype python nmap <leader>h :YcmCompleter GetDoc<cr><c-w><c-w>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args="--ignore=E501,W601,W504,E203,W503 --select=B,BLK,C,E,F,I,S,W"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_auto_jump = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_disabled_filetypes=['html']

" vim-airline
function! AirlineInit()
	let g:airline_powerline_fonts = 0
	" disable those wonky arrows - they don't look right without special fonts
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
	let g:airline_section_warning = airline#section#create(['syntastic'])
	let g:airline_exclude_preview = 1
	let g:airline_section_y = ''  " don't care about encoding
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" vim-rainbow-parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 13

"ctrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = 'find %s -type f'


" silver searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
au BufWritePre *.py :%s/\s\+$//e  " trim trailing whitespace
au BufWritePre *.py :retab        " convert tabs to spaces
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

" Clojure
au Filetype clojure nmap <c-c><c-r> :w \| !lein exec % \| more<cr>
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
let g:clj_fmt_autosave = 1


function! Tabfix()
  :set ts=2 sts=2 noet
  :retab!
  :set ts=4 sts=4 et
  :retab
endfunction
nnoremap <leader>tab :call Tabfix()<cr>

" HTML, js
au BufWritePre *.js :%s/\s\+$//e  " trim trailing whitespace
au BufWritePre *.js :retab        " convert tabs to spaces
au BufWritePre *.jsx :%s/\s\+$//e  " trim trailing whitespace
au BufWritePre *.jsx :retab        " convert tabs to spaces
autocmd FileType javascript set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab
autocmd FileType javascriptreact set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab

au BufWritePre *.html :%s/\s\+$//e  " trim trailing whitespace
au BufWritePre *.html :retab        " convert tabs to spaces
autocmd FileType html set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab
autocmd FileType htmldjango set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab


""" NIGHTOWL! 
""""" install

" install with vim-plug
"call plug#begin('~/.vim/plugged')
"Plug 'haishanh/night-owl.vim'
"call plug#end()

""""" enable 24bit true color

" If you have vim >=8.0 or Neovim >= 0.1.5
"if (has("termguicolors"))
" set termguicolors
"endif

" For Neovim 0.1.3 and 0.1.4
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

""""" enable the theme

syntax enable
" colorscheme night-owl

" To enable the lightline theme
"let g:lightline = { 'colorscheme': 'nightowl' }
