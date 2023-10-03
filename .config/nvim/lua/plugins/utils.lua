return {
  { "dkarter/bullets.vim" },
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
}
