return {
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
          vim.keymap.set("n", "<leader>ri", ":RustEnableInlayHints<CR>", { silent = true, desc = "Enable hints" })
          vim.keymap.set("n", "<leader>rI", ":RustDisableInlayHints<CR>", { silent = true, desc = "Disable hints" })
          vim.keymap.set("n", "<leader>rr", ":RustRun<CR>", { desc = "Run" })
          vim.keymap.set("n", "<leader>ra", ":RustRunnables<CR>", { desc = "Runnables" })
          vim.keymap.set("n", "<leader>rd", ":RustDebuggables<CR>", { desc = "Debuggables" })
          vim.keymap.set("n", "<leader>rk", ":RustMoveItemUp<CR>", { desc = "Move item up" })
          vim.keymap.set("n", "<leader>rj", ":RustMoveItemDown<CR>", { desc = "Move item down" })
          vim.keymap.set("n", "<leader>rh", ":RustHoverActions<CR>", { desc = "Hover Actions (help)" })
        end,
      },
    },
  },
}
