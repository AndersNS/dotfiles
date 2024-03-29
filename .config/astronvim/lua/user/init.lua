local config = {

	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "nightly", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "main", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		-- remotes = { -- easily add new remotes to track
		--   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
		--   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
		--   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
		-- },
	},

	-- Set colorscheme
	colorscheme = "catppuccin",

	-- Override highlight groups in any theme
	highlights = {
		-- duskfox = { -- a table of overrides
		--   Normal = { bg = "#000000" },
		-- },
		default_theme = function(highlights) -- or a function that returns one
			local C = require("catppuccin.colors")

			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
	},

	-- set vim options here (vim.<first_key>.<second_key> =  value)
	options = {
		opt = {
			relativenumber = true, -- sets vim.opt.relativenumber
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
		},
	},
	header = {
		[[                                   __                ]],
		[[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
		[[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
		[[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	},

	-- Default theme configuration
	default_theme = {
		diagnostics_style = { italic = true },
		-- Modify the color table
		colors = {
			-- fg = "#abb2bf",
		},
		plugins = { -- enable or disable extra plugin highlighting
			aerial = true,
			beacon = false,
			bufferline = true,
			dashboard = false,
			highlighturl = true,
			hop = false,
			indent_blankline = true,
			lightspeed = false,
			["neo-tree"] = false,
			notify = true,
			["nvim-tree"] = true,
			["nvim-web-devicons"] = true,
			rainbow = true,
			symbols_outline = false,
			telescope = true,
			vimwiki = false,
			["which-key"] = true,
		},
	},

	-- Disable AstroNvim ui features
	ui = {
		nui_input = true,
		telescope_select = true,
	},

	-- Configure plugins
	plugins = {
		-- Add plugins, the packer syntax without the "use"
		-- All other entries override the setup() call for default plugins
		["neo-tree"] = {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
				},
			},
		},
		["null-ls"] = function(config)
			local null_ls = require("null-ls")
			-- Check supported formatters and linters
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			config.sources = {
				-- Set a formatter
				null_ls.builtins.formatting.rufo,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				-- null_ls.builtins.formatting.rustfmt,

				-- Set a linter
				null_ls.builtins.diagnostics.rubocop,
				null_ls.builtins.diagnostics.eslint,
			}

			-- set up null-ls's on_attach function
			config.on_attach = function(client)
				-- NOTE: You can remove this on attach function to disable format on save
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_create_augroup("format_on_save", { clear = true })
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "Auto format before save",
						group = "format_on_save",
						pattern = "<buffer>",
						callback = function()
							vim.lsp.buf.formatting_sync({ async = true })
						end,
					})
				end
			end
			return config -- return final config table
		end,
		treesitter = {
			ensure_installed = {
				"lua",
				"bash",
				"c_sharp",
				"css",
				"dockerfile",
				"erlang",
				"html",
				"http",
				"javascript",
				"json",
				"json5",
				"llvm",
				"python",
				"rust",
				"scss",
				"sql",
				"toml",
				"tsx",
				"typescript",
				"yaml",
			},
		},
		["nvim-lsp-installer"] = {
			ensure_installed = { "sumneko_lua" },
		},
		packer = {
			compile_path = vim.fn.stdpath("data") .. "/packer_compiled.lua",
		},
	},

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = {},
		-- Extend filetypes
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	-- Modify which-key registration
	["which-key"] = {
		-- Add bindings
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- which-key registration table for normal mode, leader prefix
					-- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
					d = {
						name = "Debugger",
						b = {
							function()
								require("dap").toggle_breakpoint()
							end,
							"Toggle Breakpoint",
						},
						B = {
							function()
								require("dap").clear_breakpoints()
							end,
							"Clear Breakpoints",
						},
						c = {
							function()
								require("dap").continue()
							end,
							"Continue",
						},
						i = {
							function()
								require("dap").step_into()
							end,
							"Step Into",
						},
						l = {
							function()
								require("dapui").float_element("breakpoints")
							end,
							"List Breakpoints",
						},
						o = {
							function()
								require("dap").step_over()
							end,
							"Step Over",
						},
						q = {
							function()
								require("dap").close()
							end,
							"Close Session",
						},
						Q = {
							function()
								require("dap").terminate()
							end,
							"Terminate",
						},
						r = {
							function()
								require("dap").repl.toggle()
							end,
							"REPL",
						},
						s = {
							function()
								require("dapui").float_element("scopes")
							end,
							"Scopes",
						},
						t = {
							function()
								require("dapui").float_element("stacks")
							end,
							"Threads",
						},
						u = {
							function()
								require("dapui").toggle()
							end,
							"Toggle Debugger UI",
						},
						w = {
							function()
								require("dapui").float_element("watches")
							end,
							"Watches",
						},
						x = {
							function()
								require("dap.ui.widgets").hover()
							end,
							"Inspect",
						},
					},
				},
			},
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Extend LSP configuration
	lsp = {
		-- enable servers that you already have installed without lsp-installer
		servers = {
			-- "pyright"
		},
		skip_setup = { "rust_analyzer" },
		-- easily add or disable built in mappings added during LSP attaching
		mappings = {
			n = {
				-- ["<leader>lf"] = false -- disable formatting keymap
			},
		},
		-- add to the server on_attach function
		-- on_attach = function(client, bufnr)
		-- end,

		-- override the lsp installer server-registration function
		-- server_registration = function(server, opts)
		--   require("lspconfig")[server].setup(opts)
		-- end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {},
	},

	-- Diagnostics configuration (for vim.diagnostics.config({}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			["<C-s>"] = { ":w!<cr>", desc = "Save File" },
		},
		t = {
			-- setting a mapping to false will disable it
			-- ["<esc>"] = false,
		},
	},

	-- This function is run last
	-- good place to configuring augroups/autocommands and custom filetypes
	polish = function()
		-- Set key binding
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
	end,
}

return config
