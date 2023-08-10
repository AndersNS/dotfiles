return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = { "BufReadPre /Users/andersns/obsidian/andersns/**.md" },
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- Optional, for completion.
    "hrsh7th/nvim-cmp",

    -- Optional, for search and quick-switch functionality.
    "nvim-telescope/telescope.nvim",

    -- Optional, an alternative to telescope for search and quick-switch functionality.
    -- "ibhagwan/fzf-lua"

    -- Optional, another alternative to telescope for search and quick-switch functionality.
    -- "junegunn/fzf",
    -- "junegunn/fzf.vim"

    -- Optional, alternative to nvim-treesitter for syntax highlighting.
    -- "godlygeek/tabular",
    -- "preservim/vim-markdown",
  },
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    -- ["gf"] = require("obsidian.mapping").gf_passthrough(),
  },
  opts = {
    dir = "/Users/andersns/obsidian/andersns", -- no need to call 'vim.fn.expand' here
    disable_frontmatter = true,
    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return nil
    end,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    local keymap = vim.keymap
    -- override the 'gf' keymap to utilize Obsidian's search functionality.
    keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
      else
        return "gf"
      end
    end, { noremap = true, expr = true })

    keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch" })
    keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian" })
    keymap.set("n", "<leader>on", function()
      vim.ui.input({ prompt = "Name:" }, function(input)
        vim.cmd("ObsidianNew " .. input)
      end)
    end, { desc = "New note" })
  end,
}
