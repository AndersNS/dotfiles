return function()
	local dap = require("dap")
	dap.adapters = {
		nlua = function(callback, config)
			callback({ type = "server", host = config.host, port = config.port })
		end,
	}

	dap.adapters.codelldb = function(on_adapter)
		local stdout = vim.loop.new_pipe(false)
		local stderr = vim.loop.new_pipe(false)

		local cmd = vim.fn.expand("~/") .. ".vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb"

		local handle, pid_or_err
		local opts = {
			stdio = { nil, stdout, stderr },
			args = { "--port", 13000 },
			detached = true,
		}
		handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
			stdout:close()
			stderr:close()
			handle:close()
			if code ~= 0 then
				print("codelldb exited with code", code)
			end
		end)
		assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
		stdout:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				-- local port = chunk:match("Listening on port (%d+)")
				local port = 13000
				if port then
					vim.schedule(function()
						on_adapter({
							type = "server",
							host = "127.0.0.1",
							port = 13000,
						})
					end)
				else
					vim.schedule(function()
						require("dap.repl").append(chunk)
					end)
				end
			end
		end)
		stderr:read_start(function(err, chunk)
			assert(not err, err)
			if chunk then
				vim.schedule(function()
					require("dap.repl").append(chunk)
				end)
			end
		end)
	end

	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = true,
		},
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
