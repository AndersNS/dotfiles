local utils = require("utils")
local vars = require("variables")

local function open_note_quick_switch()
  require("lazy").load({ plugins = { "obsidian.nvim" } })
  vim.cmd("cd " .. vars.vault_path) -- TODO: Fix this when detect_cwd works
  vim.cmd("Obsidian quick_switch")
end

local function open_weekly_note()
  require("lazy").load({ plugins = { "obsidian.nvim" } })
  local week_note_name = os.date("%Y-W", os.time())
    .. string.format("%02d", utils.getWeekNumberOfYear(os.time()))
    .. ".md"
  local this_weeks_note = vars.weekly_note_path .. week_note_name
  vim.cmd("cd " .. vars.vault_path) -- TODO: Fix this when detect_cwd works
  if utils.file_exists(this_weeks_note) then
    vim.cmd("e " .. this_weeks_note)
    return
  else
    vim.cmd("e " .. this_weeks_note)
    vim.cmd("Obsidian template " .. vars.weekly_template)
    vim.cmd("w")
  end
end

local function custom_grep_picker()
  -- Custom grep picker that supports pattern syntax: "search term :: pattern"
  -- Example: "kind: Service :: manifests/**"
  -- Transforms input live as you type, no separate prompt needed
  Snacks.picker.pick({
    format = "file",
    preview = "file",
    live = true,
    ---@param opts table
    ---@param ctx snacks.picker.finder.ctx
    finder = function(opts, ctx)
      local search = ctx.filter.search or ""
      if search == "" or search:match("^%s*$") then
        return {}
      end

      -- Parse input for "search :: pattern" syntax
      local search_term, pattern = search:match("^(.-)::(.+)$")
      local args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" }

      if search_term and pattern then
        -- Trim whitespace
        search_term = search_term:match("^%s*(.-)%s*$")
        pattern = pattern:match("^%s*(.-)%s*$")

        -- Only use pattern if it's at least 3 characters and looks like a valid glob
        -- This prevents errors while typing incomplete patterns
        if
          pattern:len() >= 3
          and (
            pattern:match("%.%w+$") -- file extension like .lua
            or pattern:match("%*%*") -- has **
            or pattern:match("^[%w_%-]+/") -- starts with dir/
            or pattern:match("^%*%.%w+$") -- wildcard with extension like *.lua
          )
        then
          table.insert(args, "-g")
          table.insert(args, pattern)
        end
      else
        search_term = search
      end

      -- Only search if we have a search term
      if search_term == "" or search_term:match("^%s*$") then
        return {}
      end

      table.insert(args, "--")
      table.insert(args, search_term)

      return require("snacks.picker.source.proc").proc({
        cmd = "rg",
        args = args,
        notify = false, -- Disable error notifications
        ---@param item table
        transform = function(item)
          local line = item.text

          -- Parse the ripgrep output: file:line:col:text
          local file, lnum, col, text = line:match("^([^:]+):(%d+):(%d+):(.*)$")

          if not file then
            return { text = line }
          end

          return {
            file = file,
            pos = { tonumber(lnum) or 1, tonumber(col) or 1 },
            text = text or "",
          }
        end,
        -- Accept any exit code to avoid error notifications
        on_exit = function(state)
          return true -- Always treat as success
        end,
        -- Suppress stderr output
        on_error = function(err)
          -- Silently ignore all errors
        end,
      }, ctx)
    end,
  })
end

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>sp",
        custom_grep_picker,
        desc = "Grep with Pattern",
      },
    },
    init = function()
      -- Create user command for custom grep picker
      vim.api.nvim_create_user_command("GrepPattern", custom_grep_picker, {
        desc = "Grep with pattern support (search :: pattern)",
      })
    end,
    opts = {
      scroll = { enabled = false },
      dashboard = {
        preset = {
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { action = ":e ~/.zshrc",                          desc = "Zshrc",           icon = " ", key = "z" },
          { action = ":e ~/.config/alacritty/alacritty.toml",desc = "Alacritty",       icon = "󰑣 ", key = "a" },
          { action = ":e ~/.tmux.conf",                      desc = "Tmux",            icon = " ", key = "t" },
          { action = open_note_quick_switch,                desc = "Find Note",       icon = "󱙓 ", key = "n" },
          { action = open_weekly_note,                      desc = "Weekly Note",     icon = " ", key = "w" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        },
        sections = {
          { icon = " ", title = "Keys", section = "keys", indent = 2, padding = 1 },
          { icon = " ", pane = 2, title = "Recent", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 10,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      notifier = {
        top_down = false, -- place notifications from top to bottom
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
            },
          },
        },
        formatters = {
          file = {
            truncate = 80, -- truncate the file path to (roughly) this length
          },
        },
        sources = {
          explorer = {
            hidden = true,
          },
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },
      zen = {
        toggles = {
          dim = false,
          git_signs = false,
          mini_diff_signs = false,
          -- diagnostics = false,
          -- inlay_hints = false,
        },
        show = {
          statusline = false, -- can only be shown when using the global statusline
          tabline = false,
        },
        win = {
          style = {
            enter = true,
            fixbuf = false,
            minimal = false,
            width = 80,
            height = 0,
            backdrop = { transparent = false, blend = 40 },
            keys = { q = false },
            zindex = 40,
            wo = {
              winhighlight = "NormalFloat:Normal",
            },
          },
        },
        --- Callback when the window is opened.
        ---@param win snacks.win
        on_open = function(win) end,
        --- Callback when the window is closed.
        ---@param win snacks.win
        on_close = function(win) end,
        --- Options for the `Snacks.zen.zoom()`
        ---@type snacks.zen.Config
        zoom = {
          toggles = {},
          show = { statusline = true, tabline = true },
          win = {
            backdrop = false,
            width = 0, -- full width
          },
        },
      },

      image = {
        enabled = true,
        convert = {
          notify = false,
        },
      },
    },
  },
}
