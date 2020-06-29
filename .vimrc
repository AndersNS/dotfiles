syntax on

set hidden
" No error bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set signcolumn=yes
set number relativenumber 
set nu rnu
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set guifont=Fura\ Code\ NF
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

Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'alampros/vim-styled-jsx'
Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-commentary'

call plug#end()

let g:coc_global_extensions=[ 'coc-omnisharp', 'coc-json', 'coc-css',  'coc-tsserver']

" THEME
colorscheme gruvbox
set background=dark

" AIRLINE
" Enable tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let airline#extensions#tabline#show_splits = 0
let airline#extensions#tabline#tabs_label = ''

let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tabs_label = ''

let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline#extensions#tabline#fnamemod = ':t'

" Disable tabline close button
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamecollapse = 1

" Always show tabs
set showtabline=2

" Enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme='base16_gruvbox_dark_hard'

" We dont need to see mode anymore (covered by airline)
set noshowmode

" Set files for automatically closing tags
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,javascript'

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx,*js set filetype=typescript.tsx

" Make editorconfig and fugitive play nice together
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

if executable('rg')
    let g:rg_derive_root='true'
endif


" Make more room to display messages
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:vrfr_rg = 'true'

"Ranbow.vim config
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

autocmd FileType * RainbowParentheses

" PRETTIER 
" Allow auto formatting for files without "@format" or "@prettier" tag
let g:prettier#autoformat_require_pragma = 0
" Allow autofmrat for files that have "@format" or "@prettier" tag 
let g:prettier#autoformat = 1

" Start Screen / startify
let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]

let g:startify_bookmarks = [
            \ { 'i': '~/.vimrc'  },
            \ { 'z': '~/.zshrc'  },
            \ { 't': '~/.tmux.conf'  },
            \ '~/source',
            \ ]

let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

let g:startify_enable_special = 0

" KEYBINDS
" Set space as leader key
let mapleader = " "
" Hook up whichkey
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
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


"Prettier format
nmap <leader>py <Plug>(Prettier)

"Clear search
nnoremap <silent> <F3> :let @/ = ""<CR>


" Toggle paste mode (prevents weird indentation on paste)
set pastetoggle=<F2>

" Buffers & windows
nnoremap <leader>wh :wincmd h<CR>
nnoremap <leader>wj :wincmd j<CR>
nnoremap <leader>wk :wincmd k<CR>
nnoremap <leader>wl :wincmd l<CR>

nnoremap <leader>ws :sp<CR>
nnoremap <leader>wv :vsp<CR>
nnoremap <leader>wo :wincmd o<CR>

nnoremap <leader>q :q<CR>

nnoremap <leader>d :bd <CR>
nnoremap <leader>bd :bd <CR>
nnoremap <leader>ba :%bw \| :NERDTreeToggle<CR>

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>


" Open undotree
nnoremap <leader>u :UndotreeShow<CR>

" Files 
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>pv :NERDTreeFind<CR>

nnoremap <leader>fs :w <CR>
nnoremap <leader>fS :wa <CR>
nnoremap <leader>ff :Rg<CR>

nnoremap <leader>pf :Files<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>pg :GFiles<CR>


" Yank to system clipboard
nnoremap <Leader>y "*y<CR>

nnoremap <silent> <Leader>+ :vertical resize +5<CR>
nnoremap <silent> <Leader>- :vertical resize -5<CR>

" FZF 
" Make FZF show in the middle of the screen
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp'  } }

" Make the fzf window be top to bottom
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'

" Make fzf window follow color scheem colors
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

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
nmap <leader>gt <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gr <Plug>(coc-rename)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gq <Plug>(coc-fix-current)
" Apply AutoFix to problem on the current line.
nmap <leader>gf :CocAction doHover<CR>

nnoremap <leader>gZ :CocRestart

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

" WHICHKEY config
" Create map to add keys to
let g:which_key_map =  {}"
" Define a separator
let g:which_key_sep = '→'
let g:which_key_use_floating_win = 1
" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Single mappings
let g:which_key_map['/'] = [ ':Commentary'  , 'comment'  ]
let g:which_key_map[';'] = [ ':Commands'    , 'commands'  ]
let g:which_key_map['.'] = [ ':e ~/.vimrc'    , 'edit vimrc'  ]
let g:which_key_map['S'] = [ ':so ~/.vimrc'    , 'source vimrc'  ]
let g:which_key_map['e'] = [ ':NERDTreeToggle'    , 'explorer'  ]
let g:which_key_map['d'] = [ ':bd'    , 'delete buffer'  ]
let g:which_key_map[','] = [ ':Startify'    , 'start screen'  ]
let g:which_key_map['y'] = [ ':"*y'    , 'yank to system buffer'  ]
let g:which_key_map['u'] = [ ':UndotreeShow'    , 'undotree'  ]
let g:which_key_map['q'] = [ ':q'    , 'quit'  ]

" Ignored mappings
let g:which_key_map['+'] = [ ':vertical resize +5'    , 'which_key_ignore'  ]
let g:which_key_map['-'] = [ ':vertical resize -5', 'which_key_ignore'  ]

" Language service mappings
let g:which_key_map['g'] = {
      \ 'name' : '+language' ,
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'f' : ['CocAction doHover'                   , 'hover'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'Z' : ['CocRestart'                          , 'restart'],
      \ }


" Files
let g:which_key_map['f'] = {
      \ 'name' : '+files' ,
      \ 's' : [':w'              , 'write'],
      \ 'S' : [':wa'              , 'write all'],
      \ 'f' : [':Rg'              , 'find files'],
      \ }

call which_key#register('<Space>', "g:which_key_map")


" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
end

" Trick to prevent Startify and NERDTree crashing each other
autocmd VimEnter *
        \   if !argc()
        \ |   Startify
        \ |   NERDTree
        \ |   wincmd w
        \ | endif
