return {
  {
    "folke/twilight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      alpha = 0.8,
      context = 15,
      treesitter = true,
    },
  },
  {
    "folke/zen-mode.nvim",
    dir = "~/source/zen-mode.nvim/",
    opts = {
      window = {
        backdrop = 1,
        width = 80,
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
          font = "24", -- font size
        },
        kitty = {
          enabled = true,
          font = "+14", -- font size increment
        },
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
    },
  },
}
