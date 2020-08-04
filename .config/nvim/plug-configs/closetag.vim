" Set files for automatically closing tags
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,javascript,typescriptreact, javascriptreact'

" set filetypes as typescript.tsx
autocmd BufNewFile,BufRead *.tsx,*.jsx,*js set filetype=typescript.tsx

