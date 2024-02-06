return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("telescope").load_extension("harpoon")
    end,
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ma", ":lua require('harpoon.mark').add_file()<cr>", desc = "Add mark", silent = true },
      { "<leader>mm", ":Telescope harpoon marks<cr>", desc = "Marks", silent = true },
    },
  },
}
