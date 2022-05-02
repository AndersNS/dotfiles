local M = {}

M.config = function()
	-- set a formatter, this will override the language server formatting capabilities (if it exists)
	local formatters = require("lvim.lsp.null-ls.formatters")
	formatters.setup({
		{
			exe = "prettier",
			---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
			filetypes = { "css", "javascript", "typescript", "typescriptreact", "json", "jsonc", "html" },
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
end
return M
