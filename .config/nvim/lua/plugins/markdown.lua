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
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      bullet = {
        left_pad = 1,
        right_pad = 1,
      },
    },
  },
}
