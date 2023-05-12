local M = {}

M.kanagawa = function()
	local kanagawa = require("kanagawa")
	kanagawa.setup({
		undercurl = true, -- enable undercurls
		commentStyle = {},
		functionStyle = {},
		keywordStyle = { italic = true },
		statementStyle = { italic = true },
		typeStyle = {},
		variablebuiltinStyle = { italic = true },
		specialReturn = true,
		specialException = true,
		dimInactive = lvim.builtin.global_statusline,
		globalStatus = lvim.builtin.global_statusline,
		colors = {
			palette = { sumiInk1b = "#1b1b23" },
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(_)
			return {
				diffRemoved = { fg = "#E46876" },
				NvimTreeFolderIcon = { fg = "#7e9cd8" },
				CmpItemKindEnum = { fg = "#957FB8" },
				["@parameter"] = { fg = "#DCA561" },
			}
		end,
		theme = "wave",
		background = {
			dark = "wave",
			light = "lotus",
		},
	})
end

M.catppuccin = function()
	local catppuccin = require("catppuccin")
	local opts = {
		flavour = "mocha",
		background = { light = "latte", dark = "mocha" },
		term_colors = false,
		styles = {
			comments = {},
			keywords = { "italic" },
		},
		compile = {
			enabled = true, -- NOTE: make sure to run `:CatppuccinCompile`
			path = vim.fn.stdpath("cache") .. "/catppuccin",
		},
		dim_inactive = {
			enabled = lvim.builtin.global_statusline,
			shade = "dark",
			percentage = 0.15,
		},
		integrations = {
			cmp = true,
			fidget = true,
			lsp_trouble = true,
			telescope = true,
			treesitter = true,
			mason = true,
			neotest = lvim.builtin.test_runner == "neotest",
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = {},
					warnings = { "italic" },
					information = {},
				},
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			dap = {
				enabled = lvim.builtin.dap.active,
				enable_ui = lvim.builtin.dap.active,
			},
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			gitsigns = lvim.builtin.gitsigns.active,
			nvimtree = true,
			neotree = lvim.builtin.tree_provider == "neo-tree",
			overseer = lvim.builtin.task_runner == "overseer",
			symbols_outline = lvim.builtin.tag_provider == "symbols-outline",
			which_key = lvim.builtin.which_key.active,
			leap = lvim.builtin.motion_provider == "leap",
			hop = lvim.builtin.motion_provider == "hop",
		},
		highlight_overrides = {
			mocha = {
				NormalFloat = { fg = "#CDD6F4", bg = "#151521" },
				CmpItemKindEnum = { fg = "#B4BEFE" },
				CmpItemKindEnumMember = { fg = "#F5C2E7" },
				CmpItemMenu = { fg = "#7F849C" },
				CmpItemAbbr = { fg = "#BAC2DE" },
				Cursor = { fg = "#1e1e2e", bg = "#d9e0ee" },
				["@constant.builtin"] = { fg = "#EBA0AC" },
				TSConstBuiltin = { fg = "#EBA0AC" },
			},
		},
	}
	catppuccin.setup(opts)
end

M.rose_pine = function()
	require("rose-pine").setup({
		variant = "main",
		dark_variant = "main",
		bold_vert_split = false,
		dim_nc_background = lvim.builtin.global_statusline,
		disable_background = lvim.transparent_window,
		disable_float_background = true,
		disable_italics = true,
		---@usage string hex value or named color from rosepinetheme.com/palette
		groups = {
			border = "highlight_med",
			comment = "muted",
			link = "iris",
			punctuation = "subtle",

			error = "love",
			hint = "iris",
			info = "foam",
			warn = "gold",

			headings = {
				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},
		},
		highlight_groups = {
			Boolean = { fg = "love" },
			Cursor = { fg = "#232136", bg = "text" },
			NormalFloat = { bg = "base" },
			MsgArea = { fg = "text" },
			VertSplit = { fg = "highlight_low", bg = "highlight_low" },
			SignColumn = { fg = "text", bg = "none" },
			SignColumnSB = { fg = "text", bg = "none" },
			mkdInlineURL = { fg = "iris" },
			["@variable"] = { fg = "text" },
			["@variable.builtin"] = { fg = "love" },
			["@type"] = { fg = "foam" },
			["@text"] = { fg = "text" },
			["@property"] = { fg = "iris" },
			["@parameter"] = { fg = "iris" },
			["@constant.builtin"] = { fg = "love" },
			["@constant"] = { fg = "foam" },
			["@constructor"] = { fg = "foam" },
			["@field"] = { fg = "foam" },
			["@function.builtin"] = { fg = "love" },
			["@function"] = { fg = "rose" },
			["@include"] = { fg = "pine" },
			["@keyword"] = { fg = "pine" },
			["@keyword.operator"] = { fg = "subtle" },
			["@label"] = { fg = "foam" },
			["@punctuation.bracket"] = { fg = "muted" },
			["@punctuation.delimiter"] = { fg = "muted" },
			["@punctuation.special"] = { fg = "muted" },
			["@string.escape"] = { fg = "pine" },
			["@string.special"] = { fg = "gold" },
			["@tag"] = { fg = "foam" },
			["@tag.delimiter"] = { fg = "subtle" },
			["@text.title"] = { fg = "iris" },
			["@text.uri"] = { fg = "iris" },
			CmpItemKindText = { fg = "gold" },
			CmpItemKindConstructor = { fg = "foam" },
			CmpItemKindField = { fg = "foam" },
			CmpItemKindValue = { fg = "text" },
			CmpItemKindEvent = { fg = "text" },
			CmpItemKindUnit = { fg = "gold" },
			CmpItemKindConstant = { fg = "gold" },
			CmpItemKindModule = { fg = "iris" },
			CmpItemKindEnum = { fg = "#c5a8e8" },
			CmpItemKindStruct = { fg = "#56949f" },
			CmpItemKindTypeParameter = { fg = "foam" },
			CmpItemKindTypeKeyword = { fg = "pine" },
			CmpItemKindTypeDirectory = { fg = "foam" },
			CmpItemKindReference = { fg = "gold" },
			CmpItemKindOperator = { fg = "subtle" },
			CmpItemKindTypeSnippet = { fg = "pine" },
		},
	})
end

return M
