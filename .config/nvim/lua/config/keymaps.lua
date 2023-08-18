-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- overwrite lazyvim mappings with vim-tmux-navigator mappings
-- see: https://github.com/christoomey/vim-tmux-navigator/blob/master/plugin/tmux_navigator.vim
local keymap = vim.keymap

keymap.set("n", "<TAB>", "<cmd>BufferLineCycleNext<cr>")
keymap.set("n", "<S-TAB>", "<cmd>BufferLineCyclePrev<cr>")
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

local Util = require("lazyvim.util")
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
keymap.set("n", "<c-\\>", lazyterm, { desc = "which_key_ignore" })
keymap.set("t", "<C-\\>", "<cmd>close<cr>", { desc = "which_key_ignore" })

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
