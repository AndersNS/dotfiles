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

lvim.colorscheme = "catppuccin"
lvim.builtin.notify.active = true

lvim.auto_close_tree = 1
lvim.line_wrap_cursor_movement = false
lvim.document_highlight = true
lvim.transparent_window = false

lvim.builtin.alpha.active = false
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.dap.active = true

-- lvim.builtin.lualine.style = "lvim"

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

require("user.treesitter").config()
-- ADDITIONAL PLUGINS
require("user.plugins").config()
require("user.dap").config()
require("user.keys").config()

-- dashboard
-- lvim.dashboard.custom_header = {""}
-- lvim.dashboard.footer = {""}
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

-- require("leap").set_default_keymaps()
