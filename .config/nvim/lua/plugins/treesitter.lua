return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    enabled = false,
    opts = { mode = "cursor" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = { "razor", "c_sharp", "html" },
      matchup = {
        enable = true,
      },
      highlight = { enable = true },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      aliases = {
        ["razor"] = "html",
      },
    },
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    enabled = false,
    init = function()
      vim.o.matchpairs = "(:),{:},[:],<:>"
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "status_manual" }
    end,
  },
}
