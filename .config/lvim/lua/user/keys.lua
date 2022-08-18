local M = {}

M.config = function()
	vim.api.nvim_set_keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	-- vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-c>", "<cmd> %y+ <CR>", { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<C-b>", "<ESC>^i", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("i", "<C-e>", "<END>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("t", "<leader><esc>", "<c-\\><c-n>", { desc = "Terminal normal mode" })
	vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n><cr>", { desc = "Terminal quit" })

	lvim.keys.insert_mode["kj"] = false
	lvim.keys.insert_mode["jj"] = false
	lvim.keys.insert_mode["jk"] = false

	-- Autocommands (https://neovim.io/doc/user/autocmd.html)
	-- lvim.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}
	lvim.builtin.dap.on_config_done = function(_)
		lvim.builtin.which_key.mappings["d"]["g"] = { "<cmd>lua require('dapui').toggle() <CR>", "Toggle UI" }
	end

	lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>lua vim.lsp.buf.code_action() <CR>", "Code actions" }
	lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<CR>", "Find file" }
	lvim.builtin.which_key.mappings["c"] = { ":BufferKill<CR>", "Close buffer" }
	lvim.builtin.which_key.mappings["P"] = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		r = { "<cmd>lua require('lv-utils').reload_lv_config()<cr>", "Reload" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
		t = { "<cmd>PackerStatus<cr>", "Status" },
	}
	lvim.builtin.which_key.mappings["t"] = {
		name = "Terminal",
		h = { ":ToggleTerm size=20  direction=horizontal<CR>", "Horizontal" },
		v = { ":ToggleTerm size= direction=vertical<CR>", "Vertical" },
	}
	-- lvim.builtin.which_key.mappings["f"] = lvim.builtin.which_key.mappings["s"]
	-- lvim.builtin.which_key.mappings["s"] = { ':let @/=""<CR>', "No Highlight" }
	-- lvim.builtin.which_key.mappings["l"]["r"] = { "<cmd>Lspsaga rename<cr>", "Rename" }
	-- lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>Lspsaga lsp_finder<cr>", "References" }
	-- lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" }
	-- Not sure why config function doesnt work, but there you go, might give some errors on startup
end

return M
