vim.keymap.set(
  "n",
  "<leader>od",
  ":lua require('toggle-checkbox').toggle_checked('x')<CR>",
  { desc = "Toggle done", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>om",
  ":lua require('toggle-checkbox').toggle_checked('>')<CR>",
  { desc = "Toggle moved", silent = true }
)
vim.keymap.set(
  "n",
  "<leader>or",
  ":lua require('toggle-checkbox').toggle_checked('~')<CR>",
  { desc = "Toggle removed", silent = true }
)

vim.opt.spell = false
vim.opt.wrap = true
