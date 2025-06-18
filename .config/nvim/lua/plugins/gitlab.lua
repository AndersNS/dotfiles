return {
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    lazy = true,
    cond = function()
      local cwd = vim.fn.getcwd()
      --- Thinks cwd is nil, but it is never nil in nvim
      ---@diagnostic disable-next-line: param-type-mismatch
      if string.find(cwd, "/nhn/") then
        return true
      else
        return false
      end
    end,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      require("gitlab").setup()
    end,
  },
}
