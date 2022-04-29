local M = {}

M.config = function()
	lvim.plugins = {
		{ "sainnhe/gruvbox-material" },
		{ "EdenEast/nightfox.nvim" },
		{ "folke/tokyonight.nvim" },
		{
			"rose-pine/neovim",
			as = "rose-pine",
			config = function()
				require("user.theme").rose_pine()
				vim.cmd([[colorscheme rose-pine]])
			end,
			-- cond = function()
			-- 	local _time = os.date("*t")
			-- 	-- return (_time.hour >= 1 and _time.hour < 9)
			-- 	return false
			-- end,
		},
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("user.theme").catppuccin()

				vim.cmd([[colorscheme catppuccin]])
			end,
			-- cond = function()
			-- 	local _time = os.date("*t")
			-- 	-- return (_time.hour >= 17 and _time.hour < 21)
			-- 	return false
			-- end,
		},
		{
			"rebelot/kanagawa.nvim",
			config = function()
				require("user.theme").kanagawa()
				vim.cmd([[colorscheme kanagawa]])
			end,
			-- cond = function()
			-- 	local _time = os.date("*t")
			-- 	-- return (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1)
			-- 	return true
			-- end,
		},
		{ "stevearc/dressing.nvim" },
		{ "mzlogin/vim-markdown-toc" },
		{
			"ggandor/leap.nvim",
			config = function() end,
		},
		{ "tpope/vim-repeat" },
		{
			"tpope/vim-surround",
			keys = { "c", "d", "y" },
		},
		{ "sotte/presenting.vim", ft = { "markdown" } },
		{
			"iamcco/markdown-preview.nvim",
			run = [[sh -c 'cd app && yarn install']],
			ft = { "markdown" },
		},
		{
			"folke/lsp-colors.nvim",
			event = "BufRead",
		},
		{
			"p00f/nvim-ts-rainbow",
		},
		{ "yashguptaz/calvera-dark.nvim" },
		{ "andymass/vim-matchup" },
		{ "jxnblk/vim-mdx-js" },
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({
					"css",
					"javascript",
					html = {
						mode = "foreground",
					},
				})
			end,
		},
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup()
			end,
			ft = { "python", "rust", "go" },
			event = "BufReadPost",
			requires = { "mfussenegger/nvim-dap" },
			disable = not lvim.builtin.dap.active,
		},
		{
			"simrat39/rust-tools.nvim",
			config = function()
				require("user.rust_tools").config()
			end,
			ft = { "rust", "rs" },
		},
		{
			"mhinz/vim-startify",
			event = "BufWinEnter",
			disable = lvim.builtin.alpha.active,
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
					{ n = "~/notes" },
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
		{
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup({
					auto_open = true,
					auto_close = true,
					padding = false,
					height = 10,
					use_diagnostic_signs = true,
				})
			end,
			cmd = "Trouble",
		},
	}
end

return M
