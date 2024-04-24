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
