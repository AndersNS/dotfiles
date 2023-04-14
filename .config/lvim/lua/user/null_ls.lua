local M = {}

M.config = function()
  -- NOTE: By default, all null-ls providers are checked on startup.
  -- If you want to avoid that or want to only set up the provider
  -- when you opening the associated file-type,
  -- then you can use filetype plugins for this purpose.
  -- https://www.lunarvim.org/languages/#lazy-loading-the-formatter-setup
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end
  local sources = {
    nls.builtins.formatting.prettierd.with {
      condition = function(utils)
        return not utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.formatting.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.sqlformat,
    nls.builtins.formatting.terraform_fmt,
    -- Support for nix files
    nls.builtins.diagnostics.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.diagnostics.shellcheck,
    -- nls.builtins.diagnostics.luacheck,
    nls.builtins.diagnostics.markdownlint.with {
      filetypes = { "markdown" },
      extra_args = { "-r", "~MD013" },
    },
    nls.builtins.code_actions.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
  }
  local ts_found, typescript_code_actions = pcall(require, "typescript.extensions.null-ls.code-actions")
  if ts_found then
    table.insert(sources, typescript_code_actions)
  end

  -- you can either config null-ls itself
  nls.setup {
    on_attach = require("lvim.lsp").common_on_attach,
    debounce = 150,
    save_after_format = false,
    sources = sources,
  }
end

return M
