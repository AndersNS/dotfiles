return {
  {
    "folke/which-key.nvim",
    opts = function()
      require("which-key").register({
        ["<leader>l"] = {
          name = "+language",
        },
      })
    end,
  },
}
