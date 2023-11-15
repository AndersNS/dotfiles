return {
  {
    "folke/zen-mode.nvim",
    lazy = true,
    opts = {
      window = {
        backdrop = 1,
      },
      plugins = {
        tmux = { enabled = false },
        alacritty = {
          enabled = false,
          font = "18", -- font size
        },
      },
    },
  },
}
