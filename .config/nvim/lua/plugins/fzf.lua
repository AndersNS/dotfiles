return {
  {
    "ibhagwan/fzf-lua",

    opts = function(_, opts)
      local actions = require("fzf-lua.actions")

      return {
        files = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          actions = {
            ["ctrl-i"] = { actions.toggle_ignore },
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
  },
}
