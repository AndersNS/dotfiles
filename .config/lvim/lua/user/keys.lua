local M = {}

M.config = function()
	vim.api.nvim_set_keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<TAB>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

	-- Autocommands (https://neovim.io/doc/user/autocmd.html)
	-- lvim.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}
	lvim.builtin.dap.on_config_done = function(_)
		lvim.builtin.which_key.mappings["d"]["g"] = { "<cmd>lua require('dapui').toggle() <CR>", "Toggle UI" }
	end
	lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<CR>", "Find file" }
	lvim.builtin.which_key.mappings["h"] = nil
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
	lvim.builtin.which_key.mappings["f"] = lvim.builtin.which_key.mappings["s"]
	lvim.builtin.which_key.mappings["s"] = { ':let @/=""<CR>', "No Highlight" }
	-- lvim.builtin.which_key.mappings["l"]["r"] = { "<cmd>Lspsaga rename<cr>", "Rename" }
	-- lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>Lspsaga lsp_finder<cr>", "References" }
	-- lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" }
	-- Not sure why config function doesnt work, but there you go, might give some errors on startup
end

return M