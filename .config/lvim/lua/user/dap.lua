local M = {}

M.config = function()
  local function sep_os_replacer(str)
    local result = str
    local path_sep = package.config:sub(1, 1)
    result = result:gsub("/", path_sep)
    return result
  end
  local join_path = require("lvim.utils").join_paths

  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  dap.adapters.coreclr = {
    type = "executable",
    command = "/Users/andersns/netcoredbg/netcoredbg",
    args = { "--interpreter=vscode" },
  }

  dap.configurations.cs = {
    {
      type = "coreclr",
      name = "launch - netcoredbg",
      request = "launch",
      program = function()
        ---@diagnostic disable-next-line: redundant-parameter
        return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
      end,
    },
  }

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Neovim attach",
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
    },
  }

  dap.adapters.go = function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = { nil, stdout },
      args = { "dap", "-l", "127.0.0.1:" .. port },
      detached = true,
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      ---@diagnostic disable-next-line: need-check-nil
      stdout:close()
      ---@diagnostic disable-next-line: need-check-nil
      handle:close()
      if code ~= 0 then
        print("dlv exited with code", code)
      end
    end)
    assert(handle, "Error running dlv: " .. tostring(pid_or_err))
    ---@diagnostic disable-next-line: need-check-nil
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require("dap.repl").append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(function()
      callback({ type = "server", host = "127.0.0.1", port = port })
    end, 100)
  end
  -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
  dap.configurations.go = {
    {
      type = "go",
      name = "Debug",
      request = "launch",
      program = "${file}",
    },
    {
      type = "go",
      name = "Debug test", -- configuration for debugging test files
      request = "launch",
      mode = "test",
      program = "${file}",
    },
    -- works with go.mod packages and sub packages
    {
      type = "go",
      name = "Debug test (go.mod)",
      request = "launch",
      mode = "test",
      program = "./${relativeFileDirname}",
    },
  }

  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch flutter",
      dartSdkPath = sep_os_replacer(join_path(vim.fn.expand("~/"), "/flutter/bin/cache/dart-sdk/")),
      flutterSdkPath = sep_os_replacer(join_path(vim.fn.expand("~/"), "/flutter")),
      program = sep_os_replacer("${workspaceFolder}/lib/main.dart"),
      cwd = "${workspaceFolder}",
    },
  }

  dap.adapters.firefox = {
    type = "executable",
    command = "node",
    args = {
      join_path(
        vim.fn.expand("~/"),
        "/.vscode/extensions/firefox-devtools.vscode-firefox-debug-2.9.6/dist/adapter.bundle.js"
      ),
    },
  }

  local firefoxExecutable = "/usr/bin/firefox"
  if vim.fn.has("mac") == 1 then
    firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox"
  end

  dap.configurations.typescript = {
    {
      type = "node2",
      name = "node attach",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
    },
    {
      type = "chrome",
      name = "chrome",
      request = "attach",
      program = "${file}",
      -- cwd = "${workspaceFolder}",
      -- protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
      -- sourceMaps = true,
      sourceMapPathOverrides = {
        -- Sourcemap override for nextjs
        ["webpack://_N_E/./*"] = "${webRoot}/*",
        ["webpack:///./*"] = "${webRoot}/*",
      },
    },
    {
      name = "Debug with Firefox",
      type = "firefox",
      request = "launch",
      reAttach = true,
      sourceMaps = true,
      url = "http://localhost:6969",
      webRoot = "${workspaceFolder}",
      firefoxExecutable = firefoxExecutable,
    },
  }

  dap.configurations.typescriptreact = dap.configurations.typescript
  dap.configurations.javascript = dap.configurations.typescript
  dap.configurations.javascriptreact = dap.configurations.typescript

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
      ---@diagnostic disable-next-line: need-check-nil
      stdout:close()
      ---@diagnostic disable-next-line: need-check-nil
      stderr:close()
      ---@diagnostic disable-next-line: need-check-nil
      handle:close()
      if code ~= 0 then
        print("codelldb exited with code", code)
      end
    end)
    assert(handle, "Error running codelldb: " .. tostring(pid_or_err))
    ---@diagnostic disable-next-line: need-check-nil
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
    ---@diagnostic disable-next-line: need-check-nil
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
        ---@diagnostic disable-next-line: redundant-parameter
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = true,
    },
  }
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return M
