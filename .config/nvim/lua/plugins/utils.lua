return {
  { "dkarter/bullets.vim" },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>gD",
        "<cmd>DiffviewOpen<cr>",
        desc = "Diffview",
      },
    },
    opts = {
      hooks = {
        diff_buf_read = function(bufnr)
          -- Change local options in diff buffers
          vim.opt_local.wrap = true
          -- vim.opt_local.list = false
          -- vim.opt_local.colorcolumn = { 80 }
        end,
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
    },
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        hint = "floating-big-letter",
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      -- See https://github.com/neovim/nvim-lspconfig/issues/1931#issuecomment-1297599534
      -- An alternative solution: https://github.com/neovim/neovim/issues/20457#issuecomment-1266782345
      local banned_messages = { "No information available" }
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if msg == banned then
            return
          end
        end
        return require("notify")(msg, ...)
      end
    end,
  },
  {
    "ysmb-wtsg/in-and-out.nvim",
    config = function()
      vim.keymap.set("i", "<C-CR>", function()
        require("in-and-out").in_and_out()
      end)
    end,
  },
}
