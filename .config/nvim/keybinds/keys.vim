" This file only has keybindings that aren't covered by whichkey

" Stay in visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" Set space as leader key
let mapleader = " "

" Hook up whichkey
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Set whichkey delay (default is 1000)
set timeoutlen=500 

" Hit jj to exit insert mode
imap jj <Esc>

" Comment stuff
nnoremap <leader>/ :Commentary<CR>

" Commands
nnoremap <leader>; :Commands<CR>

" Show start screen
nnoremap <leader>, :Startify<CR> 

" Source (reload) vimrc
nnoremap <leader>S  :so ~/.vimrc<CR>
" Edit vimrc
nnoremap <leader>. :e ~/.vimrc<CR>

"Clear search
nnoremap <silent><leader>s :let @/ = ""<CR>


" Toggle paste mode (prevents weird indentation on paste)
set pastetoggle=<F2>

" Buffers & windows
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>

nnoremap <C-h> :wincmd h<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-l> :wincmd l<CR>

nnoremap <leader>ws :sp<CR>
nnoremap <leader>wv :vsp<CR>

nnoremap <leader>q :q<CR>

nnoremap <leader>d :bd<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>ba :%bw \| :CocCommand explorer<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bf :bfirst<CR>
nnoremap <leader>bl :blast<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>

" Open undotree
nnoremap <leader>u :UndotreeShow<CR>

" Explorer 
nnoremap <leader>e :CocCommand explorer<CR>
nnoremap <leader>ft :CocCommand explorer --preset floating<CR>

nnoremap <leader>p :Files<CR>

nnoremap <leader>fs :w <CR>
nnoremap <leader>fS :wa <CR>
nnoremap <leader>ff :Rg<CR>

nnoremap <leader>fg :GFiles<CR>


" Yank to system clipboard
nnoremap <Leader>y "*y<CR>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

