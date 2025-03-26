return {
  {
    "zbirenbaum/copilot.lua",
    cond = function()
      local cwd = vim.fn.getcwd()
      --- Thinks cwd is nil, but it is never nil in nvim
      ---@diagnostic disable-next-line: param-type-mismatch
      if string.find(cwd, "/nhn/") then
        return false
      elseif string.find(cwd, "/obsidian/") then
        return false
      else
        return true
      end
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = { model = "claude-3.7-sonnet" },
  },
}
