local open = io.open

local function read_file(path)
  local file = open(path, "rb") -- r read mode and b binary mode
  if not file then
    return nil
  end
  local content = file:read("*l") -- *a or *all reads the whole file, *l reads line by line
  file:close()
  return content
end

local function ollama(name, api_key, model)
  return require("codecompanion.adapters").extend("ollama", {
    name = name,
    env = {
      url = "https://chat.nhn.no/ollama",
      api_key = api_key,
    },
    headers = {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "Bearer ${api_key}",
    },
    parameters = {
      sync = true,
    },
    schema = {
      model = {
        default = model,
      },
    },
  })
end

return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    cmd = "CodeCompanion",
    event = "InsertEnter",
    opts = function()
      local cwd = vim.fn.getcwd()
      if string.find(cwd, "/nhn/") then
        local api_key = read_file("/Users/andersns/source/nhn/.api_key")
        return {
          adapters = {
            bigboy = ollama("bigboy", api_key, "gemma3:27b-it-q8_0"),
            smallboy = ollama("smallboy", api_key, "deepseek-coder-v2:16b"),
          },
          strategies = {
            chat = {
              adapter = "bigboy",
            },
            inline = {
              adapter = "smallboy",
            },
          },
        }
      end
      return {}
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
