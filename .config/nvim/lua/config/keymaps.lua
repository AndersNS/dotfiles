-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- overwrite lazyvim mappings with vim-tmux-navigator mappings
-- see: https://github.com/christoomey/vim-tmux-navigator/blob/master/plugin/tmux_navigator.vim
local keymap = vim.keymap

keymap.set("n", "<leader>r", "<cmd>Neotree reveal<cr>")

keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

keymap.set("n", "Y", "y$")

keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap.del("n", "<leader>qq")

keymap.set("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all" })

keymap.set(
  "n",
  "<leader>bf",
  "<cmd>lua require('telescope.builtin').buffers({ path_display = { 'truncate' }, sort_mru = true, sort_lastused = true })<cr>",
  { desc = "Find buffers" }
)
keymap.set(
  "n",
  "<leader>fb",
  "<cmd>lua require('telescope.builtin').buffers({ path_display = { 'truncate' }, sort_mru = true, sort_lastused = true })<cr>",
  { desc = "Find buffers" }
)
keymap.set("n", "<leader>fC", function()
  require("telescope.builtin").find_files({
    cwd = "~/.config",
  })
end, { desc = "Find Configs" })

keymap.set("n", "<leader>bw", "<cmd>:%bd<cr>", { desc = "Close all buffers" })

keymap.set(
  "n",
  "<leader>h",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

keymap.set("n", "<leader>bh", ":BufferLineCloseLeft<CR>", { desc = "Close left ", silent = true })
keymap.set("n", "<leader>bl", ":BufferLineCloseRight<CR>", { desc = "Close right ", silent = true })
keymap.set(
  "n",
  "<leader>oD",
  ":r!date -u +'\\%Y-\\%m-\\%dT\\%H:\\%M:\\%S.000Z' <CR>",
  { desc = "Print current UTC time", silent = true }
)

-- hop word
vim.keymap.set({ "n", "x", "o" }, "hw", function()
  local Flash = require("flash")

  ---@param opts Flash.Format
  local function format(opts)
    -- always show first and second label
    return {
      { opts.match.label1, opts.hl_group },
      { opts.match.label2, "Search" },
    }
  end

  Flash.jump({
    search = { mode = "search" },
    label = {
      after = false,
      before = { 0, 0 },
      uppercase = false,
      format = format,
    },
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      Flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },
        matcher = function(win)
          -- limit matches to the current label
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.label2 -- use the second label
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      for m, match in ipairs(matches) do
        match.label = labels[math.floor((m - 1) / #labels) + 1]
        -- first and second label
        match.label1 = match.label
        match.label2 = labels[(m - 1) % #labels + 1]
      end
    end,
  })
end)
