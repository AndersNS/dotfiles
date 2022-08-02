local M = {}

M.config = function()
  lvim.plugins = {
    { "sainnhe/gruvbox-material" },
    { "EdenEast/nightfox.nvim" },
    {
      "abzcoding/tokyonight.nvim",
      branch = "feat/local",
      config = function() end,
    },
    {
      "rose-pine/neovim",
      as = "rose-pine",
      config = function() end,
    },
    {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function() end,
    },
    {
      "rebelot/kanagawa.nvim",
      config = function() end,
      cond = function() end,
    },
    {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
        require("user.better-escape").config()
      end,
    },
    { "stevearc/dressing.nvim" },
    { "mzlogin/vim-markdown-toc" },
    {
      "ggandor/leap.nvim",
      config = function()
        require("leap").set_default_keymaps()
      end,
    },
    { "tpope/vim-repeat" },
    {
      "tpope/vim-surround",
      keys = { "c", "d", "y" },
    },
    { "sotte/presenting.vim", ft = { "markdown" } },
    {
      "iamcco/markdown-preview.nvim",
      run = [[sh -c 'cd app && yarn install']],
      ft = { "markdown" },
    },
    {
      "folke/lsp-colors.nvim",
      event = "BufRead",
    },
    {
      "p00f/nvim-ts-rainbow",
    },
    { "yashguptaz/calvera-dark.nvim" },
    { "andymass/vim-matchup" },
    { "jxnblk/vim-mdx-js" },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({
          "css",
          "scss",
          "javascript",
          html = {
            mode = "foreground",
          },
        })
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
      ft = { "python", "rust", "rs", "go" },
      event = "BufReadPost",
      requires = { "mfussenegger/nvim-dap" },
      disable = not lvim.builtin.dap.active,
    },
    {
      "simrat39/rust-tools.nvim",
      config = function()
        require("user.rust_tools").config()
      end,
      ft = { "rust", "rs" },
    },
    {
      "mhinz/vim-startify",
      disable = lvim.builtin.alpha.active,
      config = function()
        require("user.startify").config()
      end,
    },
    {
      "simrat39/symbols-outline.nvim",
    },
    {
      "windwp/nvim-ts-autotag",
    },
    {
      "j-hui/fidget.nvim",
      event = "BufWinEnter",
      config = function()
        require("fidget").setup({})
      end,
    },
    {
      "folke/trouble.nvim",
      config = function()
        require("trouble").setup({
          auto_open = true,
          auto_close = true,
          padding = false,
          height = 10,
          use_diagnostic_signs = true,
        })
      end,
      cmd = "Trouble",
    },
    {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      ft = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      opt = true,
      event = "BufReadPre",
      before = "williamboman/nvim-lsp-installer",
    },
  }
end

return M
