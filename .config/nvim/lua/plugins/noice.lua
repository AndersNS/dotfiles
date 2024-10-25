return {
  "folke/noice.nvim",
  opts = function(_, opts)
    table.insert(opts.routes, {
      filter = {
        event = "notify",
        find = "No information available",
      },
      opts = {
        skip = true,
        presets = {
          lsp_doc_border = true,
        },
        lsp = {
          progress = {
            enabled = false,
          },
        },
        messages = {
          enabled = false,
        },
      },
    })
    require("notify").setup({
      top_down = false,
    })
  end,
}
