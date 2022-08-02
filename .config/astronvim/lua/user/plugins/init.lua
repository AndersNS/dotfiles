return {
	-- You can disable default plugins as follows:
	["declancm/cinnamon.nvim"] = { disable = true },
	["goolord/alpha-nvim"] = { disable = true },

	-- You can also add new plugins here as well:
	-- { "andweeb/presence.nvim" },
	--
	-- nvim-cmp source for emoji
	["hrsh7th/cmp-emoji"] = {
		after = "nvim-cmp",
		config = function()
			astronvim.add_user_cmp_source("emoji")
		end,
	},
	  -- Programming, Testing, Debugging
  ["mfussenegger/nvim-dap"] = {
    module = "dap",
    config = require "user.plugins.dap",
    requires = {
      {
        "rcarriga/nvim-dap-ui",
        after = "nvim-dap",
        config = require "user.plugins.dapui",
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        after = "nvim-dap",
        config = function()
          require("nvim-dap-virtual-text").setup(require "user.plugins.dap-virtual-text")
        end,
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        after = "telescope.nvim",
        module = "telescope._extensions.dap",
        config = function()
          require("telescope").load_extension "dap"
        end,
      },
    },
  },
	-- Rust programming
	["simrat39/rust-tools.nvim"] = {
		after = { "nvim-lsp-installer" },
		ft = { "rust" },
		config = function()
			require("rust-tools").setup(require("user.plugins.rust-tools"))
		end,
	},
	["Saecki/crates.nvim"] = {
		event = { "BufRead Cargo.toml" },
		requires = { "plenary.nvim" },
		config = function()
			require("crates").setup(require("user.plugins.crates"))
			astronvim.add_user_cmp_source("crates")
		end,
	},
	{
		"mhinz/vim-startify",
		config = function()
			require("user.plugins.startify").config()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			require("catppuccin").setup({})
		end,
	},
}
