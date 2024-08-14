return {
  "max397574/better-escape.nvim",
  opts = {
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    -- keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    -- example(recommended)
    mappings = {
      i = {
        j = {
          -- These can all also be functions
          k = "<Esc>",
          j = nil,
        },
      },
      c = {
        j = {
          k = "<Esc>",
          j = nil,
        },
      },
      t = {
        j = {
          k = "<Esc>",
          j = nil,
        },
      },
      v = {
        j = {
          k = "<Esc>",
        },
      },
      s = {
        j = {
          k = "<Esc>",
        },
      },
    },
  },
}
