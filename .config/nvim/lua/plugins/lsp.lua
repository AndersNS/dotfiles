local util = require("lspconfig.util")

local format = function()
  require("lazyvim.plugins.lsp.format").format({ force = true })
end

local go_to_definition = function()
  if vim.bo.filetype == "go" then
    vim.lsp.buf.definition({
      on_list = function(options)
        if options == nil or options.items == nil or #options.items == 0 then
          return
        end

        local targetFile = options.items[1].filename
        local prefix = string.match(targetFile, "(.-)_templ%.go$")

        if prefix then
          local function_name = vim.fn.expand("<cword>")
          options.items[1].filename = prefix .. ".templ"

          vim.fn.setqflist({}, " ", options)
          vim.api.nvim_command("cfirst")

          vim.api.nvim_command("silent! /templ " .. function_name)
        else
          vim.lsp.buf.definition()
        end
      end,
    })
  else
    vim.lsp.buf.definition()
  end
end

local function go_goto_def()
  if vim.bo.filetype == "go" then
    return go_to_definition()
  else
    return vim.lsp.buf.definition()
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        ["*"] = {
          -- add any global capabilities here
          capabilities = {
            workspace = {
              fileOperations = {
                didRename = true,
                willRename = true,
              },

              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
              workspaceFolders = true,
            },
          },
        },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- ---@type LazyKeysSpec[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },

        tailwindcss = {
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = { "rust", "templ" },
          -- to fully override the default_config, change the below
          -- filetypes = {}
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { "cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "([a-zA-Z0-9\\-:]+)" },
                  { 'class: "(.*)"' },
                },
              },
            },
          },
        },
        html = {
          filetypes_include = { "templ" },
        },
        yamlls = {
          root_dir = util.root_pattern(".git"),
        },
        helm_ls = {
          root_dir = util.root_pattern(".git"),
        },
        marksman = {
          root_dir = util.root_pattern(".obsidian.vimrc", ".git"),
        },
        inlay_hints = {
          enabled = false,
        },
      },
      -- options for vim.diagnostic.config()
      ---@type vim.diagnostic.Opts
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
          },
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
    },
    keys = {
      { "<leader>lI", "<cmd>MasonLspInfo<cr>", desc = "Mason LSP Info" },
      { "<leader>ld", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>ll", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "<leader>lf", format, desc = "Format Document" },
      { "<leader>lf", format, desc = "Format Range", mode = "v" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      {
        "<leader>lA",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
      },
      { "<C-f>", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "gd", go_goto_def },
    },
  },
  {
    "mason-lspconfig.nvim",
    setup = {
      nil_ls = function(_, opts)
        -- require("lspconfig.server_configurations.nil").setup {}
      end,
      tailwindcss = function(_, opts)
        local tw = require("lspconfig.server_configurations.tailwindcss")
        opts.filetypes = opts.filetypes or {}

        -- add default filetypes
        vim.list_extend(opts.filetypes, tw.default_config.filetypes)

        -- remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)

        -- add additional filetypes
        vim.list_extend(opts.filetypes, opts.filetypes_include or {})
      end,
      desc = "source action",
      has = "codeaction",
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = false,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options

        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }

      return ret
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
}
