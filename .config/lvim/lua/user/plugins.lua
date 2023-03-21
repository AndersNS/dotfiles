local M = {}

M.config = function()
	lvim.plugins = {
		{ "eandrju/cellular-automaton.nvim" },
		{
			"rose-pine/neovim",
			name = "rose-pine",
			config = function()
				require("user.colors").rose_pine()
				lvim.colorscheme = "rose-pine"
			end,
			cond = function()
				return false
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			config = function()
				require("user.colors").catppuccin()
				lvim.colorscheme = "catppuccin"
			end,
			cond = function()
				return true
			end,
		},
		{
			"rebelot/kanagawa.nvim",
			config = function()
				require("user.colors").kanagawa()
				lvim.colorscheme = "kanagawa"
			end,
			cond = function()
				return false
			end,
		},
		{
			"max397574/better-escape.nvim",
			event = "InsertEnter",
			config = function()
				require("user.better-escape").config()
			end,
		},
		{
			"windwp/nvim-spectre",
			event = "BufRead",
			config = function()
				require("spectre").setup()
			end,
		},
		{ "towolf/vim-helm" },
		{ "stevearc/dressing.nvim" },
		{ "mrjones2014/smart-splits.nvim" },
		{ "mzlogin/vim-markdown-toc" },
		{
			"ggandor/leap.nvim",
			config = function()
				require("leap").set_default_keymaps()
			end,
		},
		{ "tpope/vim-repeat" },
		{
			"tpope/vim-surround",
			keys = { "c", "d", "y" },
		},
		{ "sotte/presenting.vim", ft = { "markdown" } },
		{
			"iamcco/markdown-preview.nvim",
			build = [[sh -c 'cd app && yarn install']],
			ft = { "markdown" },
		},
		{
			"folke/lsp-colors.nvim",
			event = "BufRead",
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "BufRead",
			config = function()
				require("lsp_signature").on_attach()
			end,
		},
		{
			"p00f/nvim-ts-rainbow",
		},
		{ "yashguptaz/calvera-dark.nvim" },
		{ "andymass/vim-matchup" },
		{ "jxnblk/vim-mdx-js", ft = "markdown mdx" },
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({
					"css",
					"scss",
					"javascript",
					html = {
						mode = "foreground",
					},
				})
			end,
		},
		{
			"simrat39/rust-tools.nvim",
			lazy = true,
			config = function()
				require("user.rust_tools").config()
			end,
			ft = { "rust", "rs" },
		},
		{
			"Saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			dependencies = { "plenary.nvim" },
			config = function()
				require("crates").setup({
					null_ls = {
						enabled = true,
						name = "Crates",
					},
				})
			end,
		},
		{
			"mhinz/vim-startify",
			enable = not lvim.builtin.alpha.active,
			config = function()
				require("user.startify").config()
			end,
		},
		{
			"sindrets/diffview.nvim",
			event = "BufRead",
		},
		{
			"nacro90/numb.nvim",
			event = "BufRead",
			config = function()
				require("numb").setup({
					show_numbers = true, -- Enable 'number' for the window while peeking
					show_cursorline = true, -- Enable 'cursorline' for the window while peeking
				})
			end,
		},
		{
			"simrat39/symbols-outline.nvim",
			config = function()
				require("symbols-outline").setup()
			end,
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
					auto_open = false,
					auto_close = true,
					padding = false,
					height = 10,
					use_diagnostic_signs = true,
				})
			end,
			cmd = "TroubleToggle",
		},
		{ "nvim-treesitter/nvim-treesitter-context" },
	}
end

return M
