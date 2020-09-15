
" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
endif

"let g:material_theme_style = 'default' | 'palenight' | 'ocean' | 'lighter' | 'darker' | 'default-community' | 'palenight-community' | 'ocean-community' | 'lighter-community' | 'darker-community'
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
colorscheme material
