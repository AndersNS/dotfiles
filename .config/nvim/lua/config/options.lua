-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.swapfile = false

-- Indents word-wrapped lines as much as the 'parent' line
vim.opt.breakindent = true
-- Ensures word-wrap does not split words
vim.opt.formatoptions = "l"
vim.opt.lbr = true

-- vim.opt.iskeyword.append(vim.opt.iskeyword, "-")
vim.opt.iskeyword:append("-")
vim.opt.conceallevel = 1

vim.filetype.add({ extension = { templ = "templ" } })

local original_notify = vim.notify

vim.notify = function(msg, level, opts)
  -- List of patterns to ignore
  local ignore_patterns = {
    "`LazyVim.ui.foldexpr` is deprecated. Please use `LazyVim.treesitter.foldexpr` instead",
    -- Add more patterns as needed
  }

  -- Check if message matches any ignore pattern
  for _, pattern in ipairs(ignore_patterns) do
    if string.match(msg, pattern) then
      return -- Don't show this notification
    end
  end

  -- Show the notification if it doesn't match ignore patterns
  original_notify(msg, level, opts)
end
