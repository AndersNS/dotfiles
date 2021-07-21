--[[
O is the global options object

Lbpreviousinters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
O.format_on_save = true
O.auto_complete = true

-- O.colorscheme = "gruvbox-material"
O.colorscheme = "lunar"
O.colorscheme = "tokyonight"
vim.g.tokyonight_style = "storm"
-- vim.g.calvera_style = 'deep ocean'
-- vim.g.calvera_italic_keywords = false
-- vim.g.calvera_borders = true
-- vim.g.calvera_contrast = true
-- vim.g.calvera_hide_eob = true

O.auto_close_tree = 1
O.line_wrap_cursor_movement = false
O.default_options.updatetime = 200
O.default_options.timeoutlen = 200
O.document_highlight = true
O.default_options.relativenumber = true
O.transparent_window = false
O.default_options.hlsearch = true

-- After changing plugin configsd exit and reopen LunarVim, Run :PackerInstall :PackerCompile
O.plugin.dashboard.active = false
O.plugin.galaxyline.active = true
O.plugin.zen.active = true
O.plugin.terminal.active = true
O.plugin.telescope.active = true
O.plugin.telescope.defaults.path_display = {}

O.user_plugins = {
  {
    "blackCauldron7/surround.nvim",
    config = function()
      require("surround").setup {}
    end,
  },
  { "sainnhe/gruvbox-material" },
  { "folke/tokyonight.nvim" },
  { "yashguptaz/calvera-dark.nvim" },
  { "andymass/vim-matchup" },
  {
    "mhinz/vim-startify",
    event = "BufWinEnter",
    disable = O.plugin.dashboard.active,
    config = function()
      vim.g.startify_session_dir = "~/.config/nvim/session"

      vim.g.startify_lists = {
        { type = "sessions", header = { "   Sessions" } },
        { type = "files", header = { "   Files" } },
        { type = "dir", header = { "   Files " .. vim.fn.getcwd() } },
        { type = "bookmarks", header = { "   Bookmarks" } },
        { type = "commands", header = { "    Commands" } },
      }

      vim.g.startify_bookmarks = {
        { i = "~/.config/lvim/lv-config.lua" },
        { z = "~/.zshrc" },
        { t = "~/.tmux.conf" },
        { a = "~/.config/alacritty/alacritty.yml" },
        { s = "~/source" },
      }

      vim.g.startify_commands = {
        { up = { "Update Plugins", ":PackerUpdate" } },
        { cp = { "Clean up Plugins", ":PackerClean" } },
        { co = { "Compile plugins", ":PackerCompile" } },
      }

      vim.g.startify_session_autoload = 1
      vim.g.startify_session_delete_buffers = 0
      vim.g.startify_change_to_vcs_root = 1
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_session_persistence = 1
      vim.g.startify_padding_left = 4

      vim.g.startify_enable_special = 0

      vim.cmd "let g:dashboard_session_directory = $HOME..'/.config/nvim/.sessions'"
      vim.cmd "let packages = len(globpath('~/.local/share/nvim/site/pack/packer/start', '*', 0, 1))"

      vim.api.nvim_exec(
        [[
    let g:startify_custom_footer = ['LuaJIT loaded '..packages..' plugins']
]],
        false
      )
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>"
      vim.cmd "nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>"

      vim.cmd "nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>"

      -- scroll down hover doc or scroll in definition preview
      vim.cmd "nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"
      -- scroll up hover doc
      vim.cmd "nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"
    end,
  },
}

-- dashboard
-- O.dashboard.custom_header = {""}
-- O.dashboard.footer = {""}

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "maintained"
O.treesitter.ignore_install = { "haskell" }
O.treesitter.highlight.enabled = false

O.lang.clang.diagnostics.virtual_text = true
O.lang.clang.diagnostics.signs = true
O.lang.clang.diagnostics.underline = true

-- python
-- add things like O.python.linter.flake8.exec_path
-- O.python.linter = 'flake8'
O.lang.python.isort = true
O.lang.python.diagnostics.virtual_text = true
O.lang.python.diagnostics.signs = true
O.lang.python.diagnostics.underline = true
O.lang.python.analysis.type_checking = "off"
O.lang.python.analysis.auto_search_paths = true
O.lang.python.analysis.use_library_code_types = true

O.lang.lua.autoformat = true

-- javascript
O.lang.tsserver.linter = "eslint"
O.lang.tsserver.formatter = "prettier"
O.lang.tsserver.autoformat = true

O.lang.tailwindcss.active = true

if O.lang.tailwindcss.active then
  require "lsp.tailwindcss-ls"
end

require "lsp.angular-ls"

-- php
O.lang.php.environment.php_version = "7.4"
O.lang.php.diagnostics.signs = true
O.lang.php.diagnostics.underline = true
O.lang.php.filetypes = { "php", "phtml" }

O.lang.rust.rust_tools.active = false

vim.api.nvim_set_keymap("n", "<TAB>", ":BufferNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":BufferPrevious<CR>", { noremap = true, silent = true })
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- O.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}

-- Additional Leader bindings for WhichKey
O.user_which_key = {
  ["p"] = { ":Telescope find_files<CR>", "Find file" },
  ["h"] = nil,
  ["s"] = { ':let @/=""<CR>', "No Highlight" },
  ["c"] = { ":BufferClose<CR>", "Close buffer" },
  P = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lv-utils').reload_lv_config()<cr>", "Reload" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
    t = { "<cmd>PackerStatus<cr>", "Status" },
  },
  f = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
  },
  l = {
    name = "LSP",

    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    A = { "<cmd>Lspsaga range_code_action<cr>", "Selected Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>silent FormatWrite<cr>", "Format" },
    h = { "<cmd>Lspsaga hover_doc<cr>", "Hover Doc" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    j = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
    k = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Next Diagnostic" },
    l = { "<cmd>Lspsaga lsp_finder<cr>", "LSP Finder" },
    L = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics" },
    p = { "<cmd>Lspsaga preview_definition<cr>", "Preview Definition" },
    q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },
    s = {
      "<cmd>SymbolsOutline<cr>",
      "Document Symbols",
    },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    t = { "<cmd>LspTypeDefinition<cr>", "Type Definition" },
    x = { "<cmd>cclose<cr>", "Close Quickfix" },
  },
}
