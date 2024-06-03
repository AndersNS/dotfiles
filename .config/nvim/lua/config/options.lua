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

-- Neovide
if vim.g.neovide then
  vim.o.guifont = "MonaspiceKR NF:h18"
  vim.g.neovide_window_blurred = true
  vim.g.neovide_show_border = false
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"

  -- Allow copy paste in neovim
  vim.keymap.set({ "n", "i", "v" }, "<D-v>", "+p<CR>")
  vim.keymap.set({ "n", "i", "v" }, "<D-c>", '"+y<CR> ')
end
