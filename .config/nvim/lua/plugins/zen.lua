return {
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      alpha = 0.8,
    },
  },
  {
    "folke/zen-mode.nvim",
    dir = "~/source/zen-mode.nvim/",
    opts = {
      window = {
        backdrop = 1,
        options = {
          number = false,
          relativenumber = false,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        tmux = { enabled = true },
        alacritty = {
          enabled = true,
          font = "40", -- font size
        },
        kitty = {
          enabled = true,
          font = "+14", -- font size increment
        },
      },
    },
  },
}
