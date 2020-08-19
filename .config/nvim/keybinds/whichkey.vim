" Hook up whichkey
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}"
highlight default link WhichKey          Function
highlight default link WhichKeySeperator Function
highlight default link WhichKeyGroup     Keyword
highlight default link WhichKeyDesc      Identifier

highlight default link WhichKeyFloating Pmenu

function! CloseAll()
    execute ":%bd \|:CocCommand explorer"
 endfunction

" Define a separator
let g:which_key_sep = '->'
let g:which_key_use_floating_win = 1

" Hide status line
" autocmd! FileType which_key
" autocmd  FileType which_key set laststatus=0 noshowmode noruler
  " \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['/'] = [ ':call Comment()'                            , 'comment'  ]
let g:which_key_map[';'] = [ ':Commands'                                  , 'commands'  ]
let g:which_key_map['S'] = [ ':so ~/.config/nvim/init.vim'                , 'source init.vim'  ]
let g:which_key_map['e'] = [ ':CocCommand explorer'                       , 'explorer'  ]
let g:which_key_map['E'] = [ ':CocCommand explorer --preset floating'     , 'explorer'  ]
let g:which_key_map['d'] = [ ':bd'                                        , 'delete buffer'  ]
let g:which_key_map[','] = [ ':Startify'                                  , 'start screen'  ]
let g:which_key_map['y'] = [ ':"*y'                                       , 'yank to system buffer'  ]
let g:which_key_map['u'] = [ ':UndotreeShow'                              , 'undotree'  ]
let g:which_key_map['q'] = [ ':q'                                         , 'quit'  ]
let g:which_key_map['p'] = [ ':Files'                                     , 'find files'  ]
let g:which_key_map['s'] = [ ':let @/ = ""'                               , 'clear search'  ]
let g:which_key_map['i'] = [ ':let @/ = ""'                               , 'clear search'  ]
let g:which_key_map['y'] = [ ':CocList -A --normal yank'                  , 'yank history'  ]
let g:which_key_map['z'] = [ ':Goyo'                                      , 'zen'  ]
let g:which_key_map['='] = [ '<C-w>='                                     , 'balance windows'  ]
let g:which_key_map['j'] = [ '<Plug>(easymotion-j)'                       , 'line motion down'  ]
let g:which_key_map['k'] = [ '<Plug>(easymotion-k)'                       , 'line motion up'  ]
let g:which_key_map['l'] = [ '<Plug>(easymotion-overwin-line)'            , 'move to line'  ]

" Ignored mappings
let g:which_key_map['+'] = [ ':vertical resize +5'    , 'which_key_ignore'  ]
let g:which_key_map['-'] = [ ':vertical resize -5'    , 'which_key_ignore'  ]

" Windows
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'h' : [':wincmd h'              , 'left'],
      \ 'j' : [':wincmd j'              , 'down'],
      \ 'k' : [':wincmd k'              , 'up'],
      \ 'l' : [':wincmd l'              , 'right'],
      \ 's' : [':sp'                    , 'horizontal split'],
      \ 'v' : [':vsp'                   , 'vertical split'],
      \ 'o' : [':wincmd o'              , 'close all other windows'],
      \ '=' : ['<C-w> ='                , 'windows same size'],
      \ }

" Buffers
let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'd' : [':bd'                            , 'close buffer'],
      \ 'a' : [':call CloseAll()'               , 'close all buffers'],
      \ 'b' : [':Buffers'                       , 'show buffers'],
      \ 'f' : [':bfirst'                        , 'first buffer'],
      \ 'l' : [':blast'                         , 'last buffer'],
      \ 'p' : [':bprevious'                     , 'previous buffer'],
      \ 'n' : [':bnext'                         , 'next buffer'],
      \ }

" Language service mappings
let g:which_key_map['g'] = {
      \ 'name' : '+language' ,
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'y' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'q' : [':CocAction doHover'                  , 'hover'],
      \ 'Q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'Z' : [':CocRestart'                         , 'restart'],
      \ 'f' : ['<Plug>(coc-format)'                  , 'format'],
      \ }

" Files
let g:which_key_map['f'] = {
      \ 'name' : '+files' ,
      \ 's' : [':w'                                         , 'write'],
      \ 'S' : [':wa'                                        , 'write all'],
      \ 'e' : [':CocCommand explorer'                       , 'toggle explorer'],
      \ 'r' : [':Farr --source=rgnvim'                      , 'replace in project'],
      \ 'b' : [':Farr --source=rgnvim'                      , 'replace in buffer'],
      \ 'f' : [':Rg'                                        , 'find files'],
      \ 'g' : [':GFiles'                                    , 'git files'],
      \ }

" Terminal
let g:which_key_map['t'] = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew'           , 'terminal'],
      \ 'f' : [':FloatermNew fzf'       , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'   , 'git'],
      \ 'n' : [':FloatermNew lazynpm'   , 'npm'],
      \ 'N' : [':FloatermNew nnn'       , 'nnn'],
      \ 'p' : [':FloatermNew python'    , 'python'],
      \ 't' : [':FloatermToggle'        , 'toggle'],
      \ }


call which_key#register('<Space>', "g:which_key_map")
