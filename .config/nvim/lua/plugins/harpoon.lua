return {
  {
    "ThePrimeagen/harpoon",
    config = function() end,
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>ma", ":lua require('harpoon.mark').add_file()<cr>", "Add mark", silent = true },
      { "<leader>mm", ":lua require('harpoon.ui').toggle_quick_menu()<cr>", "Marks", silent = true },
    },
  },
}
