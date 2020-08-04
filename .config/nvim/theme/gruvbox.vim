let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_invert_selection='0'


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif"
