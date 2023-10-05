-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- overwrite lazyvim mappings with vim-tmux-navigator mappings
-- see: https://github.com/christoomey/vim-tmux-navigator/blob/master/plugin/tmux_navigator.vim
local keymap = vim.keymap

keymap.set("n", "<leader>r", "<cmd>Neotree reveal<cr>")

keymap.set("n", "<TAB>", "<cmd>b#<cr>")
keymap.set("n", "<S-TAB>", "<cmd>b#<cr>")
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.del("n", "<leader>qq")

keymap.del("n", "<leader>ww")
keymap.del("n", "<leader>wd")
keymap.del("n", "<leader>w-")
keymap.del("n", "<leader>w|")
keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all" })

keymap.set(
  "n",
  "<leader>h",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", { desc = "Close left ", silent = true })
keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", { desc = "Close right ", silent = true })

keymap.set("n", "<c-_>", ":ToggleTerm<cr>", { silent = true })
