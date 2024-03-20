-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false

-- Indents word-wrapped lines as much as the 'parent' line
vim.opt.breakindent = true
-- Ensures word-wrap does not split words
vim.opt.formatoptions = "l"
vim.opt.lbr = true
-- vim.opt.iskeyword.append(vim.opt.iskeyword, "-")
vim.opt.iskeyword:append("-")
vim.opt.conceallevel = 1

vim.filetype.add({ extension = { templ = "templ" } })
