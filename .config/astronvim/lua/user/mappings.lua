local map = vim.keymap.set
local unmap = vim.keymap.del
local is_available = astronvim.is_available

map("t", "<leader><esc>", "<c-\\><c-n>", { desc = "Terminal normal mode" })
map("t", "<esc><esc>", "<c-\\><c-n>:q<cr>", { desc = "Terminal quit" })
