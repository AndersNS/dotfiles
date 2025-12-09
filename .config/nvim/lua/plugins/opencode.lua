return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim" },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Your custom keymaps
      vim.keymap.set("n", "<leader>oA", function()
        require("opencode").ask()
      end, { desc = "Ask opencode" })
      vim.keymap.set("n", "<leader>oa", function()
        require("opencode").ask("@cursor: ")
      end, { desc = "Ask opencode about this" })
      vim.keymap.set("v", "<leader>oa", function()
        require("opencode").ask("@selection: ")
      end, { desc = "Ask opencode about selection" })
      vim.keymap.set("n", "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle embedded opencode" })
      vim.keymap.set("n", "<leader>on", function()
        require("opencode").command("session_new")
      end, { desc = "New session" })
      vim.keymap.set("n", "<leader>oy", function()
        require("opencode").command("messages_copy")
      end, { desc = "Copy last message" })
      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("messages_half_page_up")
      end, { desc = "Scroll messages up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("messages_half_page_down")
      end, { desc = "Scroll messages down" })
      vim.keymap.set({ "n", "v" }, "<leader>op", function()
        require("opencode").select_prompt()
      end, { desc = "Select prompt" })
      vim.keymap.set("n", "<leader>oe", function()
        require("opencode").prompt("Explain @cursor and its context")
      end, { desc = "Explain code near cursor" })
    end,
  },
}
