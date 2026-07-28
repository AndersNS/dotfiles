return {
  {
    "nvim-neotest/neotest",
    opts = {
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
      require("neotest").setup({
        adapters = {
          require("neotest-vstest"),
        },
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
          ensure_installed = { "roslyn", "html-lsp" },
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
    end,
    ft = { "cs", "razor" },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = "off",
      broad_search = false,
    },
    config = function(_, opts)
      require("roslyn").setup(opts)

      vim.lsp.enable("html")

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function(args)
          local bufnr = args.buf
          if vim.bo[bufnr].filetype ~= "razor" then
            return
          end
          if vim.b[bufnr]._roslyn_dedup then
            return
          end
          vim.b[bufnr]._roslyn_dedup = true
          local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "roslyn" })
          if #clients == 0 then
            vim.b[bufnr]._roslyn_dedup = false
            return
          end
          local dedup_client_ns = function(client_name)
            local ns_list = {}
            for ns, ns_info in pairs(vim.diagnostic.get_namespaces()) do
              if ns_info.name:match("^nvim%.lsp%." .. client_name .. "%.") then
                table.insert(ns_list, ns)
              end
            end
            if #ns_list < 2 then
              return
            end
            local all_diags = {}
            for _, ns in ipairs(ns_list) do
              vim.list_extend(all_diags, vim.diagnostic.get(bufnr, { namespace = ns }))
            end
            if #all_diags < 2 then
              return
            end
            local seen = {}
            local unique = {}
            for _, d in ipairs(all_diags) do
              if not seen[d.message] then
                seen[d.message] = true
                table.insert(unique, d)
              end
            end
            if #unique < #all_diags then
              for _, ns in ipairs(ns_list) do
                vim.diagnostic.reset(ns, bufnr)
              end
              vim.diagnostic.set(ns_list[1], bufnr, unique)
            end
          end
          dedup_client_ns("roslyn")
          dedup_client_ns("html")
          vim.b[bufnr]._roslyn_dedup = false
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "razor",
        callback = function()
          vim.bo.shiftwidth = 4
          vim.bo.tabstop = 4
          vim.bo.softtabstop = 4
          vim.bo.smartindent = false
          vim.bo.indentexpr = ""
        end,
      })
    end,
  },
}
