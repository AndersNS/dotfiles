-- vim.g.rustaceanvim = {
--   -- Plugin configuration
--   tools = {},
--   -- LSP configuration
--   server = {
--     on_attach = function(_, bufnr)
--       vim.keymap.set("n", "<leader>ra", function()
--         vim.cmd.RustLsp("codeAction")
--       end, { silent = true, buffer = bufnr })
--       vim.keymap.set("n", "<leader>ci", ":RustLsp enableInlayHints<CR>", { silent = true, desc = "Enable hints" })
--       vim.keymap.set("n", "<leader>cI", ":RustLsp disableInlayHints<CR>", { silent = true, desc = "Disable hints" })
--       vim.keymap.set("n", "<leader>cR", ":RustLsp runnables<CR>", { desc = "Runnables" })
--       vim.keymap.set("n", "<leader>cD", ":RustLsp debuggables<CR>", { desc = "Debuggables" })
--       vim.keymap.set("n", "<leader>ck", ":RustLsp moveItem up<CR>", { desc = "Move item up" })
--       vim.keymap.set("n", "<leader>cj", ":RustLsp moveItem down<CR>", { desc = "Move item down" })
--       vim.keymap.set("n", "<leader>ch", ":RustLsp hoverActions<CR>", { desc = "Hover Actions (help)" })
--       -- you can also put keymaps in here
--     end,
--     -- rust-analyzer language server configuration
--     ["rust-analyzer"] = {
--
--     },
--   },
--   -- DAP configuration
--   dap = {},
-- }

return {
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^3", -- Recommended
  --   ft = { "rust" },
  -- },
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        on_initialized = function()
          vim.cmd([[
              augroup RustLSP
                autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
              augroup END
            ]])

          require("rust-tools").inlay_hints.disable()

          require("which-key").register({
            ["<leader>r"] = {
              name = "+rust",
            },
          })
          vim.keymap.set("n", "<leader>ci", ":RustEnableInlayHints<CR>", { silent = true, desc = "Enable hints" })
          vim.keymap.set("n", "<leader>cI", ":RustDisableInlayHints<CR>", { silent = true, desc = "Disable hints" })
          vim.keymap.set("n", "<leader>cR", ":RustRun<CR>", { desc = "Run" })
          vim.keymap.set("n", "<leader>cA", ":RustRunnables<CR>", { desc = "Runnables" })
          vim.keymap.set("n", "<leader>cD", ":RustDebuggables<CR>", { desc = "Debuggables" })
          vim.keymap.set("n", "<leader>ck", ":RustMoveItemUp<CR>", { desc = "Move item up" })
          vim.keymap.set("n", "<leader>cj", ":RustMoveItemDown<CR>", { desc = "Move item down" })
          vim.keymap.set("n", "<leader>ch", ":RustHoverActions<CR>", { desc = "Hover Actions (help)" })
        end,
      },
    },
  },
}
