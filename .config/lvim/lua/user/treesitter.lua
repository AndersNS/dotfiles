local M = {}

M.config = function()
  -- Treesitter
  lvim.builtin.treesitter.rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
  }

  lvim.builtin.treesitter.autotag.enable = true
  lvim.builtin.treesitter.matchup.enable = true
  lvim.builtin.treesitter.highlight.enabled = true
  lvim.builtin.treesitter.ensure_installed = "all"
  lvim.builtin.treesitter.ignore_install = { "" }

  lvim.builtin.nvimtree.width = 70
  lvim.builtin.nvimtree.side = "left"
end

return M
