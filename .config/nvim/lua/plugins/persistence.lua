return {
  {
    "folke/persistence.nvim",
    keys = function()
      return {
        {
          "<leader>ps",
          function()
            require("persistence").load()
          end,
          desc = "Restore Session",
        },
        {
          "<leader>pl",
          function()
            require("persistence").load({ last = true })
          end,
          desc = "Restore Last Session",
        },
        {
          "<leader>pd",
          function()
            require("persistence").stop()
          end,
          desc = "Don't Save Current Session",
        },
      }
    end,
  },
}
