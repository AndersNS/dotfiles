local M = {}

M.config = function()
	local status_ok, rust_tools = pcall(require, "rust-tools")
	if not status_ok then
		return
	end

	local opts = {
		tools = {
			autoSetHints = false,
			hover_with_actions = false,
			executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
			runnables = {
				use_telescope = true,
				prompt_prefix = "  ",
				selection_caret = "  ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "descending",
				layout_strategy = "vertical",
				layout_config = {
					width = 0.3,
					height = 0.50,
					preview_cutoff = 0,
					prompt_position = "bottom",
				},
			},
			debuggables = {
				use_telescope = true,
			},
			inlay_hints = {
				only_current_line = false,
				show_parameter_hints = true,
				parameter_hints_prefix = "  ",
				other_hints_prefix = "  ",
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 7,
				highlight = "Comment",
			},
			hover_actions = {
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},
				auto_focus = true,
			},
		},
		server = {
			on_attach = require("lvim.lsp").common_on_attach,
			on_init = require("lvim.lsp").common_on_init,
		},
	}
	local extension_path = vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.4/"

	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

	opts.dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	}

	rust_tools.setup(opts)
end

return M
