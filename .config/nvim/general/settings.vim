syntax enable
" No error bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set smartindent
set autoindent
set hidden
set signcolumn=yes
set number relativenumber 
set nu rnu
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set guifont=Hack\ Nerd\ Font
" set guifont=FiraCode\ Nerd\ Font
set undodir=~/.vim/undodir
set undofile
set incsearch
set mouse=a
set clipboard=unnamedplus
set scrolloff=8

set iskeyword+=- " Treat word separated by dash as text objects
set formatoptions-=cro " Stop newline continuation of comments
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set background=dark

" Always show tabs
set showtabline=2

" Make more room to display messages
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:vrfr_rg = 'true'

au BufRead,BufNewFile *.config setfiletype xml
