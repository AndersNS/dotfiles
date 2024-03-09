return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    keys = {
      {
        "<leader>gn",
        ":Neogit <cr>",
        desc = "Neogit",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>gd",
        ":DiffviewOpen ",
        desc = "Diff open",
      },
      {
        "<leader>gD",
        ":DiffviewClose <cr>",
        desc = "Diff close",
      },
    },
  },
}
