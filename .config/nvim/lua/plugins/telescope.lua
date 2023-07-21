local Util = require("lazyvim.util")

return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      { "<leader>fR", Util.telescope("resume"), desc = "Resume" },
      {
        "<leader>sB",
        ":Telescope file_browser file_browser path=%:p:h=%:p:h<cr>",
        desc = "Browse Files",
      },
    },
    config = function(_, _)
      require("telescope").load_extension("undo")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("fzf")
    end,
  },
}
