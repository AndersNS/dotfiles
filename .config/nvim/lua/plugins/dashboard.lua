local Util = require("lazyvim.util")
local utils = require("utils")
local vars = require("variables")

local function open_note_quick_switch()
  require("lazy").load({ plugins = { "obsidian.nvim" } })
  vim.cmd("cd " .. vars.vault_path) -- TODO: Fix this when detect_cwd works
  vim.cmd("ObsidianQuickSwitch")
end

local function open_weekly_note()
  require("lazy").load({ plugins = { "obsidian.nvim" } })
  local week_note_name = os.date("%Y-W", os.time()) .. tostring(utils.getWeekNumberOfYear(os.time())) .. ".md"
  local this_weeks_note = vars.weekly_note_path .. week_note_name
  vim.cmd("cd " .. vars.vault_path) -- TODO: Fix this when detect_cwd works
  if utils.file_exists(this_weeks_note) then
    vim.cmd("e " .. this_weeks_note)
    return
  else
    vim.cmd("e " .. this_weeks_note)
    vim.cmd("ObsidianTemplate " .. vars.weekly_template)
  end
end

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Telescope find_files",                desc = " Find file",       icon = " ", key = "f" },
          { action = "ene | startinsert",                   desc = " New file",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                  desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                 desc = " Find text",       icon = " ", key = "g" },
          { action = Util.telescope.config_files(),         desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',   desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                          desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "e ~/.zshrc",                          desc = " Zshrc",           icon = " ", key = "z" },
          { action = "e ~/.config/alacritty/alacritty.yml", desc = " Alacritty",       icon = "󰑣 ", key = "a" },
          { action = "e ~/.tmux.conf",                      desc = " Tmux",            icon = " ", key = "t" },
          { action = open_note_quick_switch,                desc = " Find Note",       icon = "󱙓", key = "n" },
          { action = open_weekly_note,                      desc = " Weekly Note",     icon = " ", key = "w" },
          { action = "Lazy",                                desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                  desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
}
