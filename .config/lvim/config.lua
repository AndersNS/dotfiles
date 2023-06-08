local init_custom_options = function()
	local custom_options = {
		relativenumber = true, -- Set relative numbered lines
		scrolloff = 10, -- Determines the number of context lines you would like to see above and below the cursor
		ignorecase = true, -- Ignore case in search
		smartcase = true, -- Case-sensitive search when search term contains uppercase characters. Otherwise, case-sensitive search.  timeoutlen = 200, -- Time to wait for a mapped sequence to complete (in milliseconds)
		spell = false,
		breakindent = true,
		formatoptions = "l",
		lbr = true,
	}

	for k, v in pairs(custom_options) do
		vim.opt[k] = v
	end
end
init_custom_options()
vim.opt.guifont = { "JetBrainsMono Nerd Font Mono", ":h14" }
lvim.format_on_save = true
lvim.auto_complete = true

lvim.auto_close_tree = 1
lvim.line_wrap_cursor_movement = false
lvim.document_highlight = true
lvim.transparent_window = false

lvim.builtin.nvimtree.setup.filters.dotfiles = false
lvim.builtin.nvimtree.setup.view.width = 60
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true

lvim.builtin.alpha.active = false
lvim.builtin.lualine.active = true
lvim.builtin.terminal.active = true
lvim.builtin.telescope.active = true
lvim.builtin.autopairs.active = true
lvim.builtin.dap.active = true
lvim.builtin.luasnip.sources.friendly_snippets = true
lvim.builtin.telescope.theme = "center"

lvim.builtin.terminal.direction = "vertical"
lvim.builtin.terminal.persist_size = true

lvim.builtin.terminal.size = function(term)
	if term.direction == "horizontal" then
		return vim.o.columns * 0.4
	elseif term.direction == "vertical" then
		return vim.o.columns * 0.4
	end
end

lvim.builtin.terminal.open_mapping = [[<C-\>]]

require("user.treesitter").config()
require("user.plugins").config()
-- require("user.null_ls").config()
require("user.dap").config()
require("user.formatters").config()
require("user.linters").config()
require("user.keys").config()

-- Very cool hack to fix omnisharp
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Fix startup error by disabling semantic tokens for omnisharp",
	group = vim.api.nvim_create_augroup("OmnisharpHook", {}),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.name == "omnisharp" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
