return {
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = { "neotest-vstest" },
      signs = {
        parameterized = { text = "◈" },
      },
      status = {
        virtual_text = false,
      },
    },
    init = function()
      vim.fn.sign_define("neotest_parameterized", {
        text = "◈",
        texthl = "NeotestMarked",
      })
    end,
  },
  {
    "nsidorenco/neotest-vstest",
  },
  {
    "bosvik/roslyn-diagnostics.nvim",
    -- lazy load on filetype
    ft = { "cs", "fs" },
    opts = {},
  },
  {

    "seblyng/roslyn.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
          },
          ensure_installed = { "roslyn" },
        },
      },
    },
    init = function()
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })

      -- Opt out of daemon mode (one server shared across nvim instances). When one
      -- instance disconnects, Razor's html forwarding in the shared daemon keeps a
      -- disposed connection, so razor formatting fails with ObjectDisposedException.
      -- Must be set here: plugin/roslyn.lua enables the server before `config` runs.
      vim.lsp.config("roslyn", {
        cmd = { vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin", "roslyn-language-server"), "--stdio" },
      })
    end,
    ft = { "cs", "razor" },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = "auto",
      broad_search = false,
    },
    config = function(_, opts)
      require("roslyn").setup(opts)

      -- Roslyn (and html) report the same razor diagnostics in several namespaces
      -- (push + pull). Keep the first occurrence and strip duplicates from the rest.
      local dedup_running = false
      local dedup_pending = {}

      local function dedup_client_ns(bufnr, client_name)
        local prefix = "nvim.lsp." .. client_name .. "."
        local ns_list = {}
        for ns, ns_info in pairs(vim.diagnostic.get_namespaces()) do
          if vim.startswith(ns_info.name, prefix) then
            table.insert(ns_list, ns)
          end
        end
        if #ns_list < 2 then
          return
        end
        table.sort(ns_list)

        local seen = {}
        for _, ns in ipairs(ns_list) do
          local diags = vim.diagnostic.get(bufnr, { namespace = ns })
          local kept = {}
          for _, d in ipairs(diags) do
            local key = d.lnum .. ":" .. d.message
            if not seen[key] then
              seen[key] = true
              table.insert(kept, d)
            end
          end
          -- Only touch namespaces that actually had duplicates
          if #kept < #diags then
            vim.diagnostic.set(ns, bufnr, kept)
          end
        end
      end

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        pattern = { "*.razor", "*.cshtml" },
        callback = function(args)
          local bufnr = args.buf
          -- Ignore events fired by our own vim.diagnostic.set, and coalesce bursts
          if dedup_running or dedup_pending[bufnr] then
            return
          end
          dedup_pending[bufnr] = true
          vim.schedule(function()
            dedup_pending[bufnr] = nil
            if not vim.api.nvim_buf_is_valid(bufnr) then
              return
            end
            dedup_running = true
            pcall(dedup_client_ns, bufnr, "roslyn")
            pcall(dedup_client_ns, bufnr, "html")
            dedup_running = false
          end)
        end,
      })
    end,
  },
}
