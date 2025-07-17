return {
  {
    "zbirenbaum/copilot.lua",
    cond = function()
      local cwd = vim.fn.getcwd()
      --- Thinks cwd is nil, but it is never nil in nvim
      ---@diagnostic disable-next-line: param-type-mismatch
      if string.find(cwd, "/obsidian/") then
        return false
      -- elseif string.find(cwd, "/nhn/") then
      --   return false
      else
        return true
      end
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    opts = { model = "claude-sonnet-4" },
    build = "make tiktoken", -- Only on MacOS or Linux
  },
}
