return {
  {
    "jxnblk/vim-mdx-js",
    {
      "instant-markdown/vim-instant-markdown",
      ft = { "markdown" },
      build = "yarn install",
      config = function()
        vim.g.instant_markdown_autostart = 0
      end,
    },
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    enabled = false,
    opts = {
      markdown = {
        bullets = { "", "", "", "" },
        fat_headlines = true,
        fat_headline_upper_string = "▄",
        fat_headline_lower_string = "▀",
      },
    },
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("render-markdown").setup({})
    end,
  },
  -- install without yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
