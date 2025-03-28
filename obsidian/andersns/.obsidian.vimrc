imap jk <Esc>
imap jj <Esc>

" Yank to system clipboard
set clipboard=unnamed

unmap <Space>

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

exmap toggleleft obcommand app:toggle-left-sidebar
nmap <Space>e :toggleleft<CR>
