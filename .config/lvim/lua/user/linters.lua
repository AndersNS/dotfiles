local M = {}

M.config = function()
	-- set a formatter, this will override the language server formatting capabilities (if it exists)
	local linters = require("lvim.lsp.null-ls.linters")
	linters.setup({
		{
			exe = "eslint_d",
			---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
			filetypes = { "javascript", "typescript", "typescriptreact" },
		},
	})
end
return M
