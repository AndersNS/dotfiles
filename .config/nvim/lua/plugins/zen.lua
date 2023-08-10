return {
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 1,
      },
      plugins = {
        tmux = { enabled = false },
        alacritty = {
          enabled = true,
          font = "18", -- font size
        },
      },
    },
  },
}
