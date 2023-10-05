return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        shade_terminals = false,
        direction = "float",
        -- add --login so ~/.zprofile is loaded
        -- https://vi.stackexchange.com/questions/16019/neovim-terminal-not-reading-bash-profile/16021#16021
        shell = "zsh --login",
        float_opts = {
          border = "shadow",
        },
      })
    end,
    keys = {
      { [[<C-\>]] },
      { "<leader>0", "<Cmd>2ToggleTerm<Cr>", desc = "Terminal #2" },
      {
        "<leader>th",
        "<cmd>ToggleTerm size=40 direction=horizontal<cr>",
        desc = "Open a horizontal terminal at the Desktop directory",
      },
    },
  },
}
