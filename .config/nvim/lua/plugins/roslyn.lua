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

      vim.lsp.config("html", {
        ft_exclude = { "razor" },
        on_attach = function(_, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          vim.bo[bufnr].shiftwidth = 4
          vim.bo[bufnr].tabstop = 4
          vim.bo[bufnr].softtabstop = 4
        end,
        settings = {
          html = {
            format = {
              wrapLineLength = 120,
              tabSize = 4,
              insertSpaces = true,
              wrapAttributes = "preserve-aligned",
              templating = true,
              indentInnerHtml = false,
              contentUnformatted = "pre,code,textarea,script,style",
            },
          },
        },
      })
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

      vim.lsp.config("roslyn", {
        on_attach = function(_, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
          ["csharp|background_analysis"] = {
            ["background_analysis.dotnet_analyzer_diagnostics_scope"] = "openFiles",
            ["background_analysis.dotnet_compiler_diagnostics_scope"] = "openFiles",
          },
        },
      })
    end,
  },
}
