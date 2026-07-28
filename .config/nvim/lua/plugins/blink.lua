return {
  {
    "saghen/blink.cmp",
    optional = true,
    opts = {
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
      },
      sources = {
        default = { "filemention", "lsp", "path", "snippets", "buffer" },
        providers = {
          filemention = {
            name = "filemention",
            module = "filemention.sources.blink",
          },
        },
      },
    },
  },
}
