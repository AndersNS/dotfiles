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

lvim.format_on_save = true
lvim.auto_complete = true
lvim.lsp.automatic_servers_installation = true

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

lvim.builtin.terminal.persist_size = true
lvim.builtin.terminal.size = function(term)
	if term.direction == "horizontal" then
		return 15
	elseif term.direction == "vertical" then
		return vim.o.columns * 0.4
	end
end
require("user.treesitter").config()
require("user.plugins").config()
require("user.dap").config()
require("user.formatters").config()
require("user.keys").config()
