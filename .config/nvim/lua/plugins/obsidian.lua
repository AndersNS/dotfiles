local vars = require("variables")

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- to use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  enabled = not vim.fn.has('macunix'),

  -- event = { "BufReadPre " .. vars.vault_path .. "/**.md" },
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md" },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- Optional, for completion.
    "hrsh7th/nvim-cmp",

    -- Optional, for search and quick-switch functionality.
    -- "nvim-telescope/telescope.nvim",

    -- Optional, an alternative to telescope for search and quick-switch functionality.
    -- "ibhagwan/fzf-lua",

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
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
  },
  opts = {
    ui = {
      enable = false,
    },
    workspaces = {
      {
        name = "andersns",
        path = vars.vault_path,
      },
    },
    disable_frontmatter = true,
    templates = {
      subdir = "Extras/Templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Calendar/Daily",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "Daily-template.md",
    },
    new_notes_location = "+ Encounters",
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "snacks.pick",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    local keymap = vim.keymap

    keymap.set("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch" })
    keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian" })
    keymap.set("n", "<leader>on", function()
      vim.ui.input({ prompt = "Name:" }, function(input)
        vim.cmd("ObsidianNew " .. input)
      end)
    end, { desc = "New note" })
  end,
}
