return {
  {
    "not-manu/filemention.nvim",
    event = "InsertEnter",
    dependencies = { "dmtrKovalenko/fff.nvim" },
    opts = { finder = "fff" },
  },
  {
    "dmtrKovalenko/fff.nvim",
    build = function()
      -- downloads a prebuilt binary or falls back to cargo build
      require("fff.download").download_or_build_binary()
    end,
    -- build = "nix run .#release",
    opts = {
      title = "Files",
      debug = {
        enabled = false,
        show_scores = false,
      },
      layout = {
        height = 0.9,
        width = 0.9,
        preview_position = "right", -- 'left' | 'right' | 'top' | 'bottom'
        prompt_position = "top",
        preview_size = 0.5,
        path_shorten_strategy = "middle_number", -- 'middle_number' | 'middle' | 'end' | 'start'
      },
    },
    lazy = false, -- the plugin lazy-initialises itself
    keys = {
      {
        "ff",
        function()
          require("fff").find_files()
        end,
        desc = "FFFind files",
      },
      {
        "fg",
        function()
          require("fff").live_grep()
        end,
        desc = "LiFFFe grep",
      },
      {
        "fz",
        function()
          require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
        end,
        desc = "Live fffuzy grep",
      },
      {
        "fc",
        function()
          require("fff").live_grep({ query = vim.fn.expand("<cword>") })
        end,
        desc = "Search current word",
      },
    },
  },
}
