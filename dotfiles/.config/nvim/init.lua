local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "oxfist/night-owl.nvim",
  "zbirenbaum/copilot.lua",
  "vim-syntastic/syntastic",
  "vim-airline/vim-airline",
  "preservim/nerdtree",
  "frazrepo/vim-rainbow"
})

require("copilot").setup(options)

vim.cmd([[
au!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CORE EDITING SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
colorscheme night-owl
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
set shell=/bin/zsh
set splitright
set splitbelow

syntax on # disabling: sometimes messes with tabs
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

" go into insert mode when opening a terminal
autocmd TermOpen * startinsert | set nonu 
" close terminal buffer when terminal is closed
autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif

" open a terminal, start ipython, bring cursor back to previous window
" NOTE: this only makes sense when g:slime_target = "neovim"
" nnoremap <S-n> :vsplit \| term ipython<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LANGUAGES
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
autocmd BufWritePre *.py :%s/\s\+$//e  " trim trailing whitespace
autocmd BufWritePre *.py :retab        " convert tabs to spaces
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

function! Tabfix()
  :set ts=2 sts=2 noet
  :retab!
  :set ts=4 sts=4 et
  :retab
endfunction
nnoremap <leader>tab :call Tabfix()<cr>

" HTML, js
autocmd BufWritePre *.js :%s/\s\+$//e  " trim trailing whitespace
autocmd BufWritePre *.js :retab        " convert tabs to spaces
autocmd BufWritePre *.jsx :%s/\s\+$//e  " trim trailing whitespace
autocmd BufWritePre *.jsx :retab        " convert tabs to spaces
autocmd FileType javascript set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab
autocmd FileType javascriptreact set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab

autocmd BufWritePre *.html :%s/\s\+$//e  " trim trailing whitespace
autocmd BufWritePre *.html :retab        " convert tabs to spaces
autocmd FileType html set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab
autocmd FileType htmldjango set tabstop=2|set softtabstop=2|set shiftwidth=2|set expandtab
]])

vim.cmd([[
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_python_exec = "/Users/bryan/.venv/bin/python3"
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_flake8_args="--ignore=E501,W601,W504,E203,W503 --select=B,BLK,C,E,F,I,S,W"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"let g:syntastic_auto_jump = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_disabled_filetypes=["html"]

" NERDtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-S-t> :NERDTreeFind<CR>
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

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
let g:rainbow_active = 1
autocmd Syntax * RainbowLoad
]])
