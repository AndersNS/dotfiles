local format = function()
  LazyVim.format({ force = true })
end

--- root_dir that resolves to the nearest directory containing one of `markers`
---@param markers string[]
local function root(markers)
  return function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, markers))
  end
end

-- For templ: jump from the generated *_templ.go file to the .templ source
local go_to_definition = function()
  if vim.bo.filetype ~= "go" then
    return vim.lsp.buf.definition()
  end
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
          keys = {
            { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason" },
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
              desc = "Source Action",
            },
            { "<C-f>", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
            { "gd", go_to_definition, desc = "Goto Definition" },
          },
        },
        lua_ls = {
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
          root_dir = root({ ".git" }),
          -- exclude a filetype from the default_config
          filetypes_exclude = { "markdown" },
          -- add additional filetypes to the default_config
          filetypes_include = { "rust", "templ" },
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
        -- Also used by roslyn.nvim for the html parts of razor files
        html = {
          filetypes = { "html", "templ" },
          on_attach = function(_, bufnr)
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            vim.bo[bufnr].shiftwidth = 4
            vim.bo[bufnr].tabstop = 4
            vim.bo[bufnr].softtabstop = 4
          end,
          settings = {
            html = {
              format = {
                -- Must be 0: Razor merges html edits line by line, so wrapped lines
                -- make every following line indent one step further.
                wrapLineLength = 0,
                tabSize = 4,
                insertSpaces = true,
                wrapAttributes = "preserve-aligned",
                templating = true,
                indentInnerHtml = false,
                contentUnformatted = "pre,code,textarea,script,style",
              },
            },
          },
        },
        yamlls = {
          root_dir = root({ ".git" }),
        },
        helm_ls = {
          root_dir = root({ ".git" }),
        },
        marksman = {
          root_dir = root({ ".obsidian.vimrc", ".git" }),
        },
        dockerls = {
          init_options = {
            provideFormatter = false,
          },
        },
      },
      inlay_hints = {
        enabled = false,
        exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
      },
      codelens = {
        enabled = false,
      },
    },
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
