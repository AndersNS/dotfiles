return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "float",
        popup = { -- settings that apply to float position only
          size = {
            height = "80%",
            width = "30%",
          },
          position = "50%", -- 50% means center it
          title = function(state) -- format the text that appears at the top of a popup window
            return "Neo-tree " .. state.name:gsub("^%l", string.upper)
          end,
          -- you can also specify border here, if you want a different setting from
          -- the global popup_border_style.
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
          never_show = {},
        },
      },
    },
  },
}
