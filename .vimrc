syntax on

set hidden
" No error bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set number relativenumber 
set nu rnu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
"
" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

"set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" PLUGINS
" AutoInstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'peitalin/vim-jsx-typescript'
Plug 'gruvbox-community/gruvbox'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'

call plug#end()

" THEME
colorscheme gruvbox
set background=dark

let g:airline_powerline_fonts = 1
let g:airline_theme='base16_gruvbox_dark_hard'
" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx,*js set filetype=typescript.tsx

" Make editorconfig and fugitive play nice together
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

if executable('rg')
    let g:rg_derive_root='true'
endif

" PRETTIER 
" Allow auto formatting for files without "@format" or "@prettier" tag
let g:prettier#autoformat_require_pragma = 0


" KEYBINDS
" Set space as leader key
let mapleader = " "

nnoremap <Leader>src  :so ~/.vimrc<CR>
nnoremap <Leader>erc :e ~/.vimrc<CR>

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:vrfr_rg = 'true'
"
"Prettier format
nmap <leader>py <Plug>(Prettier)

"Clear search
nnoremap <F3> :set hlsearch!<CR>

" Toggle paste mode (prevents weird indentation on paste)
set pastetoggle=<F2>

" Change window focus
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" Open undotree
nnoremap <leader>u :UndotreeShow<CR>
" Show files
nnoremap <leader>pv :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>gf :GFiles<CR>

" Yank to system clipboard
nnoremap <C-c> "*y<CR>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" COC

" Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try  `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)

" Apply AutoFix to problem on the current line.
nmap <leader>qf :CocAction doHover<CR>

nnoremap <leader>cr :CocRestart

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

