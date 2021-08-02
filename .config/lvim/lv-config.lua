-- general
lvim.format_on_save = true
lvim.auto_complete = true

-- O.colorscheme = "gruvbox-material"
-- O.colorscheme = "lunar"
lvim.colorscheme = "tokyonight"
vim.g.tokyonight_style = "storm"

lvim.auto_close_tree = 1
lvim.line_wrap_cursor_movement = false
-- lvim.default_options.relativenumber = true
-- lvim.default_options.hlsearch = true
lvim.document_highlight = true
lvim.transparent_window = false

-- After changing plugin configsd exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = false
lvim.builtin.galaxyline.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true
lvim.builtin.telescope.defaults.path_display = {}
lvim.builtin.compe.autocomplete = true

lvim.lsp.default_keybinds = true

lvim.plugins = {
	{
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({})
		end,
	},
	{ "sainnhe/gruvbox-material" },
	{ "folke/tokyonight.nvim" },
	{ "yashguptaz/calvera-dark.nvim" },
	{ "andymass/vim-matchup" },
	{
		"mhinz/vim-startify",
		event = "BufWinEnter",
		disable = lvim.builtin.dashboard.active,
		config = function()
			vim.g.startify_session_dir = "~/.config/nvim/session"

			vim.g.startify_lists = {
				{ type = "sessions", header = { "   Sessions" } },
				{ type = "files", header = { "   Files" } },
				{ type = "dir", header = { "   Files " .. vim.fn.getcwd() } },
				{ type = "bookmarks", header = { "   Bookmarks" } },
				{ type = "commands", header = { "    Commands" } },
			}

			vim.g.startify_bookmarks = {
				{ i = "~/.config/lvim/lv-config.lua" },
				{ z = "~/.zshrc" },
				{ t = "~/.tmux.conf" },
				{ a = "~/.config/alacritty/alacritty.yml" },
				{ s = "~/source" },
			}

			vim.g.startify_commands = {
				{ up = { "Update Plugins", ":PackerUpdate" } },
				{ cp = { "Clean up Plugins", ":PackerClean" } },
				{ co = { "Compile plugins", ":PackerCompile" } },
			}

			vim.g.startify_session_autoload = 1
			vim.g.startify_session_delete_buffers = 0
			vim.g.startify_change_to_vcs_root = 1
			vim.g.startify_fortune_use_unicode = 1
			vim.g.startify_session_persistence = 1
			vim.g.startify_padding_left = 4

			vim.g.startify_enable_special = 0

			vim.cmd("let g:dashboard_session_directory = $HOME..'/.config/nvim/.sessions'")
			vim.cmd("let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))")

			vim.api.nvim_exec(
				[[
    let g:startify_custom_footer = ['LuaJIT loaded '..packages..' plugins']
]],
				false
			)
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
	},
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			vim.cmd("nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>")
			vim.cmd("nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>")

			-- scroll down hover doc or scroll in definition preview
			vim.cmd("nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
			-- scroll up hover doc
			vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

			if not lvim.lsp.default_keybinds then
				-- lsp provider to find the cursor word definition and reference
				vim.cmd("nnoremap <silent> gr <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>")

				-- code action
				vim.cmd("nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>")
				vim.cmd("vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>")

				-- show hover doc
				vim.cmd("nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")

				-- show signature help
				vim.cmd("nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")

				-- rename
				vim.cmd("nnoremap <silent>gR <cmd>lua require('lspsaga.rename').rename()<CR>")

				-- preview definition
				vim.cmd("nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>")

				-- show diagnostics
				vim.cmd("nnoremap <silent><leader>gl <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>")

				-- jump diagnostic
				vim.cmd("nnoremap <silent> gn <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>")
				vim.cmd("nnoremap <silent> gp <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")
			end
		end,
	},
}

-- dashboard
-- lvim.dashboard.custom_header = {""}
-- lvim.dashboard.footer = {""}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = false

lvim.lang.lua.autoformat = true

lvim.lang.tailwindcss.active = true
if lvim.lang.tailwindcss.active then
  require "lsp.tailwind-ls"
end

-- javascript
lvim.lang.typescript.linter = { "eslint" }
lvim.lang.typescript.formatters = {
	{
		exe = "prettier",
		args = {},
	},
}

lvim.lang.typescriptreact.linter = { "eslint" }
lvim.lang.typescriptreact.formatters = {
	{
		exe = "prettier",
		args = {},
	},
}

lvim.lang.tailwindcss.active = true

require("lsp.angular-ls")

vim.api.nvim_set_keymap("n", "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}

-- Additional Leader bindings for WhichKey
lvim.builtin.which_key.mappings["p"] = { ":Telescope find_files<CR>", "Find file" }
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["s"] = { ':let @/=""<CR>', "No Highlight" }
lvim.builtin.which_key.mappings["c"] = { ":BufferClose<CR>", "Close buffer" }
lvim.builtin.which_key.mappings["P"] = {
	name = "Packer",
	c = { "<cmd>PackerCompile<cr>", "Compile" },
	i = { "<cmd>PackerInstall<cr>", "Install" },
	r = { "<cmd>lua require('lv-utils').reload_lv_config()<cr>", "Reload" },
	s = { "<cmd>PackerSync<cr>", "Sync" },
	u = { "<cmd>PackerUpdate<cr>", "Update" },
	t = { "<cmd>PackerStatus<cr>", "Status" },
}
lvim.builtin.which_key.mappings["f"] = {
	name = "Search",
	b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	f = { "<cmd>Telescope find_files<cr>", "Find File" },
	h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
	M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
	r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	R = { "<cmd>Telescope registers<cr>", "Registers" },
	t = { "<cmd>Telescope live_grep<cr>", "Text" },
}
lvim.builtin.which_key.mappings["L"] = {
	name = "LSP",
	A = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
	a = { "<cmd>Lspsaga range_code_action<cr>", "Selected Action" },
	d = {
		"<cmd>Telescope lsp_document_diagnostics<cr>",
		"Document Diagnostics",
	},
	w = {
		"<cmd>Telescope lsp_workspace_diagnostics<cr>",
		"Workspace Diagnostics",
	},
	f = { "<cmd>silent FormatWrite<cr>", "Format" },
	h = { "<cmd>Lspsaga hover_doc<cr>", "Hover Doc" },
	i = { "<cmd>LspInfo<cr>", "Info" },
	j = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
	k = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic" },
	l = { "<cmd>Lspsaga lsp_finder<cr>", "LSP Finder" },
	L = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
	p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
	q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
	r = { "<cmd>Lspsaga rename<cr>", "Rename" },
	s = {
		"<cmd>SymbolsOutline<cr>",
		"Document Symbols",
	},
	S = {
		"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
		"Workspace Symbols",
	},
	t = { "<cmd>LspTypeDefinition<cr>", "Type Definition" },
	x = { "<cmd>cclose<cr>", "Close Quickfix" },
}
