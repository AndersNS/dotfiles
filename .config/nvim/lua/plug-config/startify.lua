vim.g.startify_session_dir = '~/.config/nvim/session'

vim.g.startify_lists = {{
        type = 'sessions',
        header = {'   Sessions'}
    }, {
        type = 'files',
        header = {'   Files'}
    }, {
        type = 'dir',
        header = {'   Files ' .. vim.fn.getcwd()}
    }, {
        type = 'bookmarks',
        header = {'   Bookmarks'}
    }, {
    type = 'commands',
    header = {'    Commands'}
  }
}


vim.g.startify_bookmarks = {
   { i = '~/.config/nvim/init.lua'  },
   { z = '~/.zshrc'  },
   { t = '~/.tmux.conf'  },
   { a = '~/.config/alacritty/alacritty.yml'  },
   { s = '~/source' }
}

vim.g.startify_commands = { {
  up = { "Update Plugins", ":PackerUpdate" }
}, {
  cp = { "Clean up Plugins", ":PackerClean" }
},
  {
    co = { "Compile plugins", ":PackerCompile"}
  }
}

vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1

vim.g.startify_enable_special = 0
