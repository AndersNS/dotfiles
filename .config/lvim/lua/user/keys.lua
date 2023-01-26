local M = {}

M.config = function()
	vim.api.nvim_set_keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-c>", "<cmd> %y+ <CR>", { noremap = true, silent = false })
	vim.api.nvim_set_keymap("i", "<C-b>", "<ESC>^i", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("i", "<C-e>", "<END>", { noremap = true, silent = true })

	vim.api.nvim_set_keymap("t", "<leader><esc>", "<c-\\><c-n>", { desc = "Terminal normal mode" })
	vim.api.nvim_set_keymap("t", "<esc><esc>", "<c-\\><c-n><cr>", { desc = "Terminal quit" })

	lvim.keys.insert_mode["kj"] = false
	lvim.keys.insert_mode["jj"] = false
	lvim.keys.insert_mode["jk"] = false

	-- resize with arrows
	vim.keymap.set("n", "<Left>", require("smart-splits").resize_left)
	vim.keymap.set("n", "<Down>", require("smart-splits").resize_down)
	vim.keymap.set("n", "<Up>", require("smart-splits").resize_up)
	vim.keymap.set("n", "<Right>", require("smart-splits").resize_right)

	-- Autocommands (https://neovim.io/doc/user/autocmd.html)
	-- lvim.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}
	lvim.builtin.dap.on_config_done = function(_)
		lvim.builtin.which_key.mappings["d"]["g"] = { "<cmd>lua require('dapui').toggle() <CR>", "Toggle UI" }
	end

	lvim.builtin.which_key.setup.plugins.registers = true

	lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>lua vim.lsp.buf.code_action() <CR>", "Code actions" }
	lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<CR>", "Find file" }
	lvim.builtin.which_key.mappings["c"] = { ":BufferKill<CR>", "Close buffer" }
	lvim.builtin.which_key.mappings["t"] = {
		name = "Terminal",
		h = { ":ToggleTerm size=20  direction=horizontal<CR>", "Horizontal" },
		v = { ":ToggleTerm size= direction=vertical<CR>", "Vertical" },
		t = { "<cmd>TroubleToggle<cr>", "trouble" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
		q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
		l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
		r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
	}
end

return M
