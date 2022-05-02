local M = {}

M.config = function()
	lvim.plugins = {
		{ "sainnhe/gruvbox-material" },
		{ "EdenEast/nightfox.nvim" },
		-- { "folke/tokyonight.nvim" },
		{
			"abzcoding/tokyonight.nvim",
			branch = "feat/local",
			config = function()
				require("user.theme").tokyonight()
				vim.cmd([[colorscheme tokyonight]])
			end,
			cond = function()
				local _time = os.date("*t")
				return _time.hour >= 9 and _time.hour < 17
			end,
		},
		{
			"rose-pine/neovim",
			as = "rose-pine",
			config = function()
				require("user.theme").rose_pine()
				vim.cmd([[colorscheme rose-pine]])
			end,
			cond = function()
				local _time = os.date("*t")
				return (_time.hour >= 1 and _time.hour < 9)
			end,
		},
		{
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				require("user.theme").catppuccin()

				vim.cmd([[colorscheme catppuccin]])
			end,
			cond = function()
				local _time = os.date("*t")
				return (_time.hour >= 17 and _time.hour < 21)
			end,
		},
		{
			"rebelot/kanagawa.nvim",
			config = function()
				require("user.theme").kanagawa()
				vim.cmd([[colorscheme kanagawa]])
			end,
			cond = function()
				local _time = os.date("*t")
				return (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1)
			end,
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
				require("user.startify").config()
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
		{
			"jose-elias-alvarez/nvim-lsp-ts-utils",
			ft = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
			opt = true,
			event = "BufReadPre",
			before = "williamboman/nvim-lsp-installer",
		},
	}
end

return M
