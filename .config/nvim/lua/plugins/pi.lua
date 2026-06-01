return {
  {
    "pablopunk/pi.nvim",
    keys = {
      {
        "<leader>ai",
        ":PiAsk<CR>",
        mode = "n",
        desc = "Ask pi",
      },
      {
        "<leader>ai",
        ":PiAskSelection<CR>",
        mode = "v",
        desc = "Ask pi (selection)",
      },
    },
  },
}
