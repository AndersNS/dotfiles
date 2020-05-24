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

highlight ColorColumn ctermbg=0 guibg=lightgrey


" AutoInstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'editorconfig/editorconfig-vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'peitalin/vim-jsx-typescript'
Plug 'leafgarland/typescript-vim'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'git@github.com:ctrlpvim/ctrlp.vim.git'

call plug#end()

colorscheme gruvbox
set background=dark

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx,*js set filetype=typescript.tsx

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Set space as leader key
let mapleader = " "

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0

" Change window focus
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" Open undotree
nnoremap <leader>u :UndotreeShow<CR>
" Show files
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
map <C-n> :NERDTreeToggle<CR>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" YouCompleteMe Bindings
nnoremap <buffer> <silent> <leader>gd :YcmCompleter GoTo<CR>
nnoremap <buffer> <silent> <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <buffer> <silent> <leader>rr :YcmCompleter RefactorRename<space>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
