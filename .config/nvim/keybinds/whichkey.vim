" Create map to add keys to
let g:which_key_map =  {}"

" Define a separator
let g:which_key_sep = '->'
let g:which_key_use_floating_win = 0

set timeoutlen=500

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['/'] = [ ':call Comment()'                  , 'comment'  ]
let g:which_key_map[';'] = [ ':Commands'                        , 'commands'  ]
let g:which_key_map['S'] = [ ':so ~/.config/nvim/init.vim'      , 'source init.vim'  ]
let g:which_key_map['e'] = [ ':CocCommand explorer'             , 'explorer'  ]
let g:which_key_map['d'] = [ ':bd'                              , 'delete buffer'  ]
let g:which_key_map[','] = [ ':Startify'                        , 'start screen'  ]
let g:which_key_map['y'] = [ ':"*y'                             , 'yank to system buffer'  ]
let g:which_key_map['u'] = [ ':UndotreeShow'                    , 'undotree'  ]
let g:which_key_map['q'] = [ ':q'                               , 'quit'  ]
let g:which_key_map['p'] = [ ':Files'                           , 'find files'  ]
let g:which_key_map['s'] = [ ':let @/ = ""'                     , 'clear search'  ]
let g:which_key_map['i'] = [ ':let @/ = ""'                     , 'clear search'  ]
let g:which_key_map['y'] = [ ':CocList -A --normal yank'        , 'yank history'  ]

" Ignored mappings
let g:which_key_map['+'] = [ ':vertical resize +5'    , 'which_key_ignore'  ]
let g:which_key_map['-'] = [ ':vertical resize -5', 'which_key_ignore'  ]

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

let g:which_key_map['b'] = {
      \ 'name' : '+buffers' ,
      \ 'd' : [':bd'                            , 'close buffer'],
      \ 'a' : [':%bw \| :CocCommand explorer'   , 'close all buffers'],
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
      \ 'f' : [':Rg'                                        , 'find files'],
      \ 'g' : [':GFiles'                                    , 'git files'],
      \ 't' : [':CocCommand explorer'                       , 'toggle explorer'],
      \ 'e' : [':CocCommand explorer --preset floating'     , 'toggle explorer'],
      \ }

" Terminal
let g:which_key_map['t'] = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew'                                   , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ }


call which_key#register('<Space>', "g:which_key_map")
