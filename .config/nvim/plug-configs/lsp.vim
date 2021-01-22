:lua << END
  require'lspconfig'.tsserver.setup{}
END

nnoremap <silent>gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>K     <cmd>lua vim.lsp.buf.hover()<CR>
