local extension_path = vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

return {
	dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
	server = {
		cargo = {
			loadOutDirsFromCheck = true,
		},
		checkOnSave = {
			command = "clippy",
		},
		experimental = {
			procAttrMacros = true,
		},
		workspace = {
			symbol = {
				search = {
					kind = "all_symbols",
				},
			},
		},
	},
	tools = {
		inlay_hints = {
			parameter_hints_prefix = "  ",
			other_hints_prefix = "  ",
		},
	},
}
