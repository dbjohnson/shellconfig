colorscheme delek
set number
set tabstop=4
set shiftwidth=4
filetype plugin on
filetype indent on
syntax enable
set smartindent
set hlsearch
highlight Search cterm=NONE ctermfg=white  ctermbg=red

" Sourced from: http://amix.dk/vim/vimrc.html
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
