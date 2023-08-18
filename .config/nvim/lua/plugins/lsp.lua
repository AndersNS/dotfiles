return {
  "neovim/nvim-lspconfig",
  init = function()
    local format = function()
      require("lazyvim.plugins.lsp.format").format({ force = true })
    end
    local M = require("lazyvim.plugins.lsp.keymaps")
    local keys = M.get()
    keys[#keys + 1] = { "<leader>ld", vim.diagnostic.open_float, desc = "Line Diagnostics" }
    keys[#keys + 1] = { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" }
    keys[#keys + 1] = { "<leader>ll", "<cmd>LspInfo<cr>", desc = "Lsp Info" }
    keys[#keys + 1] = { "<leader>lf", format, desc = "Format Document", has = "formatting" }
    keys[#keys + 1] = { "<leader>lf", format, desc = "Format Range", mode = "v", has = "rangeFormatting" }
    keys[#keys + 1] =
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
    keys[#keys + 1] = {
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
      has = "codeAction",
    }
    keys[#keys + 1] =
      { "<C-f>", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" }
  end,
}
