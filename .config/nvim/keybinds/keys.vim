" This file only has keybindings that aren't covered by whichkey

" Stay in visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" Set space as leader key
let mapleader = " "
nnoremap <Space> <Nop>

" Hit jj to exit insert mode
imap jj <Esc>

" Save
nnoremap <C-s> :w<cr>
inoremap <C-s> <Esc>:w<cr>

nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

if exists('g:vscode')
  " Simulate same TAB behavior in VSCode
  nmap <Tab> :Tabnext<CR>
  nmap <S-Tab> :Tabprev<CR>
else
  " Toggle paste mode (prevents weird indentation on paste)
  set pastetoggle=<F2>

  " TAB in general mode will move to text buffer
  nnoremap <silent> <TAB> :bnext<CR>
  " SHIFT-TAB will go back
  nnoremap <silent> <S-TAB> :bprevious<CR>

  " Use alt + hjkl to resize windows
  nnoremap <silent> <M-j>    :resize -2<CR>
  nnoremap <silent> <M-k>    :resize +2<CR>
  nnoremap <silent> <M-l>    :vertical resize -2<CR>
  nnoremap <silent> <M-h>    :vertical resize +2<CR>

  " Use option + hjkl to resize windows
  nnoremap <silent> ∆    :resize -2<CR>
  nnoremap <silent> ˚    :resize +2<CR>
  nnoremap <silent> ¬    :vertical resize -2<CR>
  nnoremap <silent> ˙    :vertical resize +2<CR>

endif

