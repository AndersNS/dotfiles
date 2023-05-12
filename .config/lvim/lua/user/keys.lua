local M = {}

M.config = function()
	vim.api.nvim_set_keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
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

	lvim.builtin.which_key.mappings["s"]["s"] = { "<cmd>lua require('spectre').open()<CR>", "Open spectre" }
	lvim.builtin.which_key.mappings["s"]["w"] =
		{ "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Word search" }
	lvim.lsp.buffer_mappings.visual_mode["<leader>s"] = { "<esc>:lua require('spectre').open_visual()<CR>", "Spectre" }

	lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>lua vim.lsp.buf.code_action() <CR>", "Code actions" }
	lvim.builtin.which_key.mappings["l"]["T"] = { "<cmd>TroubleToggle<cr>", "Trouble toggle" }
	lvim.builtin.which_key.mappings["l"]["t"] = { "<cmd>Trouble<cr>", "Trouble" }
	vim.api.nvim_set_keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap(
		"i",
		"<C-s>",
		"<cmd>lua vim.lsp.buf.signature_help()<cr>",
		{ noremap = true, silent = true }
	)

	vim.api.nvim_set_keymap(
		"n",
		"]e",
		"<cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap(
		"n",
		"[e",
		"<cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })

	lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<CR>", "Find file" }
	lvim.builtin.which_key.mappings["v"] = { '"0p', "Paste from zero" }
	lvim.builtin.which_key.mappings["c"] = { ":BufferKill<CR>", "Close buffer" }
	lvim.builtin.which_key.mappings["t"] = {
		name = "Terminal",
		h = { ":ToggleTerm size=20  direction=horizontal<CR>", "Horizontal" },
		v = { ":ToggleTerm size=20 direction=vertical<CR>", "Vertical" },
		w = { ":ToggleTerm direction=window<CR>", "Window" },
	}

	lvim.builtin.which_key.mappings["a"] = {
		name = "A.I.",
		s = { "<cmd>Copilot suggestion<cr>", "Toggle Copilot suggestion" },
		p = { "<cmd>Copilot panel<cr>", "Toggle Copilot panel" },
		t = { "<cmd>Copilot toggle<cr>", "Toggle Copilot" },
	}
end

return M
