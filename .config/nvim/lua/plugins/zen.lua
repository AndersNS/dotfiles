return {
  {
    "folke/zen-mode.nvim",
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
          enabled = false,
          font = "18", -- font size
        },
        kitty = {
          enabled = true,
          font = "+4", -- font size increment
        },
      },
    },
  },
}
