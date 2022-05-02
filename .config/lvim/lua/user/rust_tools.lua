local M = {}

M.config = function()
	local status_ok, rust_tools = pcall(require, "rust-tools")
	if not status_ok then
		return
	end

	vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

	local lsp_installer_servers = require("nvim-lsp-installer.servers")
	local _, requested_server = lsp_installer_servers.get_server("rust_analyzer")

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
				parameter_hints_prefix = "<-",
				other_hints_prefix = "=>",
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
			cmd_env = requested_server._default_options.cmd_env,
			on_attach = require("lvim.lsp").common_on_attach,
			on_init = require("lvim.lsp").common_on_init,
		},
	}
	local extension_path = vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.0/"

	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

	opts.dap = {
		adapter = require("rust-tools.dap").get_new_codelldb_adapter(codelldb_path, liblldb_path),
	}

	lvim.builtin.which_key.mappings["r"] = {
		name = "Rust",
		h = { "<cmd>RustToggleInlayHints<CR>", "ToggleHints" },
		r = { "<cmd>RustRunnables<CR>", "Runnables" },
		d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
		g = { "<cmd>RustViewCrateGraph<CR>", "Create Graph" },
		a = { "<cmd>RustHoverActions<CR>", "Actions" },
	}

	rust_tools.setup(opts)
end

return M
