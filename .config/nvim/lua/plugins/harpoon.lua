return {
  -- {
  --   -- version 1
  --   "ThePrimeagen/harpoon",
  --   enabled = false,
  --   config = function()
  --     require("telescope").load_extension("harpoon")
  --   end,
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --   },
  --   keys = {
  --     { "<leader>ma", ":lua require('harpoon.mark').add_file()<cr>", desc = "Add mark", silent = true },
  --     { "<leader>mm", ":Telescope harpoon marks<cr>", desc = "Marks", silent = true },
  --   },
  -- },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    keys = {
      {
        "<leader>ma",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon file",
      },
      {
        "<leader>mm",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon quick menu",
      },
      {
        "<leader>1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon to file 1",
      },
      {
        "<leader>2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon to file 2",
      },
      {
        "<leader>3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon to file 3",
      },
      {
        "<leader>4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon to file 4",
      },
      {
        "<leader>5",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Harpoon to file 5",
      },
      {
        "<leader>!",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon to file 1",
      },
      {
        "<leader>@",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon to file 2",
      },
      {
        "<leader>#",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon to file 3",
      },
      {
        "<leader>$",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon to file 4",
      },
      {
        "<leader>%",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Harpoon to file 5",
      },
    },
  },
}
