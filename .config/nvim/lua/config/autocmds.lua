-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Very cool hack to fix omnisharp
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Fix startup error by disabling semantic tokens for omnisharp",
  group = vim.api.nvim_create_augroup("OmnisharpHook", {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil and client.name == "omnisharp" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
