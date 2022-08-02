return function()
	local dap = require("dap")
	dap.adapters = {
		nlua = function(callback, config)
			callback({ type = "server", host = config.host, port = config.port })
		end,
	}
	dap.configurations = {
		-- Lua config, using https://github.com/jbyuki/one-small-step-for-vimkind
		lua = {
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
			host = function()
				local value = vim.fn.input("Host [127.0.0.1]: ")
				if value ~= "" then
					return value
				end
				return "127.0.0.1"
			end,
			port = function()
				local val = tonumber(vim.fn.input("Port: "))
				assert(val, "Please provide a port number")
				return val
			end,
			-- For Go, using https://github.com/ray-x/go.nvim
			-- For Flutter, using https://github.com/akinsho/flutter-tools.nvim
			-- For Rust, using https://github.com/simrat39/rust-tools.nvim
		},
	}
	vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticWarn" })
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticInfo" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
	vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })
end
