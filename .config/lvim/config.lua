-- settings
local init_custom_options = function()
	local custom_options = {
		relativenumber = true, -- Set relative numbered lines
		scrolloff = 10, -- Determines the number of context lines you would like to see above and below the cursor
		ignorecase = true, -- Ignore case in search
		smartcase = true, -- Case-sensitive search when search term contains uppercase characters. Otherwise, case-sensitive search.  timeoutlen = 200, -- Time to wait for a mapped sequence to complete (in milliseconds)
		spell = false,
	}

	for k, v in pairs(custom_options) do
		vim.opt[k] = v
	end
end
init_custom_options()

-- general
lvim.format_on_save = true
lvim.auto_complete = true
lvim.lsp.automatic_servers_installation = true

lvim.colorscheme = "tokyonight"
vim.g.tokyonight_style = "night"

-- lvim.colorscheme = "onedarker"

-- lvim.colorscheme = "gruvbox-material"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_disable_italic_comment = 1

lvim.auto_close_tree = 1
lvim.line_wrap_cursor_movement = false
-- lvim.default_options.relativenumber = true
-- lvim.default_options.hlsearch = true
lvim.document_highlight = true
lvim.transparent_window = false

-- After changing plugin configsd exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = false
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true
lvim.builtin.autopairs.active = true

lvim.builtin.lualine.style = "lvim"
-- lvim.builtin.lualine.options = {
-- 	theme = "gruvbox-material",
-- }
-- Treesitter
lvim.builtin.treesitter.rainbow = {
	enable = true,
	colors = {
		"Gold",
		"Orchid",
		"DodgerBlue",
		-- "Cornsilk",
		-- "Salmon",
		-- "LawnGreen",
	},
	disable = { "html" },
}
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }

-- lvim.builtin.nvimtree.width = 70
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1

lvim.plugins = {
	{
		"blackCauldron7/surround.nvim",
		config = function()
			require("surround").setup({})
		end,
	},
	{ "sainnhe/gruvbox-material" },
	{ "sotte/presenting.vim", ft = { "markdown" } },
	{
		"iamcco/markdown-preview.nvim",
		run = [[sh -c 'cd app && yarn install']],
		ft = { "markdown" },
	},
	{ "folke/tokyonight.nvim" },
	{ "yashguptaz/calvera-dark.nvim" },
	{ "andymass/vim-matchup" },
	{ "jxnblk/vim-mdx-js" },
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
				{ i = "~/.config/lvim/config.lua" },
				{ z = "~/.zshrc" },
				{ t = "~/.tmux.conf" },
				{ a = "~/.config/alacritty/alacritty.yml" },
				{ k = "~/.config/kitty/kitty.conf" },
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
			vim.cmd("let packages = len(globpath('~/.local/share/lunarvim/site/pack/packer/start', '*', 0, 1))")

			vim.api.nvim_exec(
				[[
    let g:startify_custom_footer = ['    Loaded '..packages..' plugins  ']
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
	},
	{
		"j-hui/fidget.nvim",
		event = "BufWinEnter",
		config = function()
			require("fidget").setup({})
		end,
	},
	-- {
	-- 	"glepnir/lspsaga.nvim",
	-- 	config = function()
	-- 		vim.cmd("nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>")
	-- 		vim.cmd("nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>")

	-- 		-- scroll down hover doc or scroll in definition preview
	-- 		vim.cmd("nnoremap <silent> <C-f> <cmd>LspSaga smart_scroll_with_saga(1)<CR>")
	-- 		-- scroll up hover doc
	-- 		vim.cmd("nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")

	-- 			-- lsp provider to find the cursor word definition and reference
	-- 			vim.cmd("nnoremap <silent> gr <cmd>Lspsaga lsp_finder<CR>")

	-- 			-- code action
	-- 			-- vim.cmd("nnoremap <silent><leader>ca <cmd>Lspsaga code_actionCR>")
	-- 			-- vim.cmd("vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>")

	-- 			-- show hover doc
	-- 			vim.cmd("nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")

	-- 			-- show signature help
	-- 			vim.cmd("nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")

	-- 			-- rename
	-- 			vim.cmd("nnoremap <silent>gR <cmd>lua require('lspsaga.rename').rename()<CR>")

	-- 			-- preview definition
	-- 			vim.cmd("nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>")

	-- 			-- show diagnostics
	-- 			vim.cmd("nnoremap <silent><leader>gl <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>")

	-- 			-- jump diagnostic
	-- 			vim.cmd("nnoremap <silent> gn <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>")
	-- 			vim.cmd("nnoremap <silent> gp <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")
	-- 	end,
	-- },
	-- {
	-- 	"tzachar/cmp-tabnine",
	-- 	config = function()
	-- 		local tabnine = require("cmp_tabnine.config")
	-- 		tabnine:setup({
	-- 			max_lines = 1000,
	-- 			max_num_results = 20,
	-- 			sort = true,
	-- 		})
	-- 	end,

	-- 	run = "./install.sh",
	-- 	requires = "hrsh7th/nvim-cmp",
	-- },
	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "document_diagnostics",
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- preview item
					next = "j", -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = true, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
			})
		end,
	},
}

-- dashboard
-- lvim.dashboard.custom_header = {""}
-- lvim.dashboard.footer = {""}
-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		exe = "prettier",
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "javascript", "typescript", "typescriptreact", "json", "jsonc", "html" },
	},
	{
		exe = "stylua",
		filetypes = { "lua" },
	},
	{
		exe = "uncrustify",
		filetypes = { "cs" },
	},
})

vim.api.nvim_set_keymap("n", "<C-q>", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
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
-- lvim.builtin.which_key.mappings["l"]["r"] = { "<cmd>Lspsaga rename<cr>", "Rename" }
-- lvim.builtin.which_key.mappings["l"]["R"] = { "<cmd>Lspsaga lsp_finder<cr>", "References" }
-- lvim.builtin.which_key.mappings["l"]["a"] = { "<cmd>Lspsaga code_action<cr>", "Code Action" }
-- lvim.builtin.which_key.mappings["l"]["L"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" }
