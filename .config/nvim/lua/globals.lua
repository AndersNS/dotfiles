CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

O = {
    auto_close_tree = 0,
    auto_complete = true,
    colorscheme = 'gruvbox-material',
    hidden_files = true,
    wrap_lines = false,
    number = true,
    relative_number = true,
    shell = 'bash',
    timeoutlen = 100,
    nvim_tree_disable_netrw = 0,
    extras = false,

    -- @usage pass a table with your desired languages
    treesitter = {
        ensure_installed = "all",
        ignore_install = {"haskell"},
        highlight = {enabled = true},
        playground = {enabled = true},
        rainbow = {enabled = false}
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},
lang = {
    python = {
      linter = "",
      -- @usage can be 'yapf', 'black'
      formatter = "",
      autoformat = false,
      isort = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      analysis = {
        type_checking = "basic",
        auto_search_paths = true,
        use_library_code_types = true,
      },
    },
    dart = {
      sdk_path = "/usr/lib/dart/bin/snapshots/analysis_server.dart.snapshot",
    },
    lua = {
      -- @usage can be 'lua-format'
      formatter = "",
      autoformat = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
    },
   sh = {
      -- @usage can be 'shellcheck'
      linter = "",
      -- @usage can be 'shfmt'
      formatter = "",
      autoformat = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
    },
    tsserver = {
      -- @usage can be 'eslint'
      linter = "",
      -- @usage can be 'prettier'
      formatter = "",
      autoformat = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
    },
    json = {
      -- @usage can be 'prettier'
      formatter = "",
      autoformat = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
    },
    tailwindcss = {
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
      },
    },
    clang = {
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      cross_file_rename = true,
      header_insertion = "never",
      autoformat = false, -- update this to true for enabling autoformat
    },
    ruby = {
      diagnostics = {
        virtualtext = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      filetypes = { "rb", "erb", "rakefile", "ruby" },
    },
    go = {},
    elixir = {},
    vim = {},
    yaml = {},
    terraform = {},
    rust = {
      rust_tools = {
        active = false,
      },
      linter = "",
      formatter = "",
      autoformat = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
    },
    svelte = {},
    php = {
      format = {
        braces = "psr12",
      },
      environment = {
        php_version = "7.4",
      },
      autoformat = false,
      diagnostics = {
        virtual_text = { spacing = 0, prefix = "" },
        signs = true,
        underline = true,
      },
      filetypes = { "php", "phtml" },
    },
    latex = {},
    kotlin = {},
    html = {},
    elm = {},
    emmet = { active = true },
    graphql = {},
    efm = {},
    docker = {},
    cmake = {},
    java = {},
    css = {
      formatter = "",
      autoformat = false,
      virtual_text = true,
    },
  }, 
}
