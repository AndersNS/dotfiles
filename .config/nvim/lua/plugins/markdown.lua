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
      -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'
      -- There are two special states for unchecked & checked defined in the markdown grammar
      checkbox = {
        -- Turn on / off checkbox state rendering
        enabled = true,
        -- Additional modes to render checkboxes
        render_modes = false,
        -- Determines how icons fill the available space:
        --  inline:  underlying text is concealed resulting in a left aligned icon
        --  overlay: result is left padded with spaces to hide any additional text
        position = "inline",
        unchecked = {
          -- Replaces '[ ]' of 'task_list_marker_unchecked'
          icon = "󰄱 ",
          -- Highlight for the unchecked icon
          highlight = "RenderMarkdownUnchecked",
          -- Highlight for item associated with unchecked checkbox
          scope_highlight = nil,
        },
        checked = {
          -- Replaces '[x]' of 'task_list_marker_checked'
          icon = "󰱒 ",
          -- Highlight for the checked icon
          highlight = "RenderMarkdownChecked",
          -- Highlight for item associated with checked checkbox
          scope_highlight = nil,
        },
        -- Define custom checkbox states, more involved as they are not part of the markdown grammar
        -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
        -- Can specify as many additional states as you like following the 'todo' pattern below
        --   The key in this case 'todo' is for healthcheck and to allow users to change its values
        --   'raw':             Matched against the raw text of a 'shortcut_link'
        --   'rendered':        Replaces the 'raw' value when rendering
        --   'highlight':       Highlight for the 'rendered' icon
        --   'scope_highlight': Highlight for item associated with custom checkbox
        custom = {
          later = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
          moved = { raw = "[>]", rendered = "󰧚 ", highlight = "RenderMarkdownTodo", scope_highlight = nil },
          important = {
            raw = "[!]",
            rendered = " ",
            highlight = "RenderMarkdownTodo",
            scope_highlight = "RenderMarkdownInfo",
          },
          deleted = {
            raw = "[~]",
            rendered = "󰮉 ",
            highlight = "RenderMarkdownTodo",
            scope_highlight = "RenderMarkdownHtmlComment",
          },
        },
      },
      bullet = {
        left_pad = 1,
        right_pad = 1,
      },
      heading = {
        -- Turn on / off heading icon & background rendering.
        enabled = true,
        -- Additional modes to render headings.
        render_modes = true,
        -- Turn on / off any sign column related rendering.
        sign = false,
        -- Replaces '#+' of 'atx_h._marker'.
        -- Output is evaluated depending on the type.
        -- | function | `value(context)`              |
        -- | string[] | `cycle(value, context.level)` |
        -- icons = {},
        -- Determines how icons fill the available space.
        -- | right   | '#'s are concealed and icon is appended to right side                          |
        -- | inline  | '#'s are concealed and icon is inlined on left side                            |
        -- | overlay | icon is left padded with spaces and inserted on left hiding any additional '#' |
        position = "overlay",
        -- Added to the sign column if enabled.
        -- Output is evaluated by `cycle(value, context.level)`.
        -- signs = { "󰫎 " },
        -- Width of the heading background.
        -- | block | width of the heading text |
        -- | full  | full width of the window  |
        -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
        width = "block",
        -- Amount of margin to add to the left of headings.
        -- Margin available space is computed after accounting for padding.
        -- If a float < 1 is provided it is treated as a percentage of available window space.
        -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
        left_margin = 0,
        -- Amount of padding to add to the left of headings.
        -- Output is evaluated using the same logic as 'left_margin'.
        left_pad = 0,
        -- Amount of padding to add to the right of headings when width is 'block'.
        -- Output is evaluated using the same logic as 'left_margin'.
        right_pad = 0,
        -- Minimum width to use for headings when width is 'block'.
        -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
        min_width = 0,
        -- Determines if a border is added above and below headings.
        -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
        border = false,
        -- Always use virtual lines for heading borders instead of attempting to use empty lines.
        border_virtual = false,
        -- Highlight the start of the border using the foreground highlight.
        border_prefix = false,
        -- Used above heading for border.
        above = "▄",
        -- Used below heading for border.
        below = "▀",
        -- Highlight for the heading icon and extends through the entire line.
        -- Output is evaluated by `clamp(value, context.level)`.
        backgrounds = {
          "RenderMarkdownH1Bg",
          "RenderMarkdownH2Bg",
          "RenderMarkdownH3Bg",
          "RenderMarkdownH4Bg",
          "RenderMarkdownH5Bg",
          "RenderMarkdownH6Bg",
        },
        -- Highlight for the heading and sign icons.
        -- Output is evaluated using the same logic as 'backgrounds'.
        foregrounds = {
          "RenderMarkdownH1",
          "RenderMarkdownH2",
          "RenderMarkdownH3",
          "RenderMarkdownH4",
          "RenderMarkdownH5",
          "RenderMarkdownH6",
        },
        -- Define custom heading patterns which allow you to override various properties based on
        -- the contents of a heading.
        -- The key is for healthcheck and to allow users to change its values, value type below.
        -- | pattern    | matched against the heading text @see :h lua-pattern |
        -- | icon       | optional override for the icon                       |
        -- | background | optional override for the background                 |
        -- | foreground | optional override for the foreground                 |
        custom = {},
      },
    },
  },
}
