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


" Enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_theme='base16_gruvbox_dark_hard'

" We dont need to see mode anymore (covered by airline)
set noshowmode
