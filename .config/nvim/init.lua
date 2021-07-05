require('globals')

if (true) then
    require('globals');
    vim.cmd('luafile ' .. CONFIG_PATH .. '/settings.lua')
    require('vim-settings')
    require('plugins')
    require('keys')
    require('colorscheme')
    require('plug-config/lualine')
    require('plug-config/comment')
    require('plug-config/startify')
    require('plug-config/compe')
    require('plug-config/telescope')
    require('plug-config/rnvimr')
    require('plug-config/treesitter')
    require('plug-config/fterm')
    require('plug-config/barbar')
    require('plug-config/autopairs')
    require('plug-config/whichkey')
    require('plug-config/rooter')

    -- LSP
    require('lsp')
    require('lsp/angular-ls')
else
    vim.cmd('source ' .. CONFIG_PATH .. '/initOld.vim')
end

