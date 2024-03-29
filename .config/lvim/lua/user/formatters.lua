local M = {}

M.config = function()
	-- set a formatter, this will override the language server formatting capabilities (if it exists)
	local formatters = require("lvim.lsp.null-ls.formatters")
	formatters.setup({
		{
			exe = "prettierd",
			---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
			filetypes = {
				"markdown",
				"css",
				"javascript",
				"typescript",
				"typescriptreact",
				"json",
				"jsonc",
				"html",
				"prisma",
			},
		},
		{
			exe = "stylua",
			filetypes = { "lua" },
		},
		{
			exe = "uncrustify",
			filetypes = { "cs" },
		},
		{
			exe = "rustfmt",
			filetypes = { "rust" },
		},
	})
end
return M
