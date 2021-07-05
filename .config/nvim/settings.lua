-- O is the global options object
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
-- general
O.auto_complete = true
O.relative_number = false
O.timeoutlen = 100
O.leader_key = ' '

-- if you don't want all the parsers change this to a table of the ones you want
O.treesitter.ensure_installed = "all"
O.treesitter.ignore_install = {"haskell"}
O.treesitter.highlight.enabled = true

-- lua
O.lang.lua.autoformat = true
O.lang.lua.formatter = 'lua-format'

-- javascript
O.lang.tsserver.formatter = 'prettier'
O.lang.tsserver.linter = 'eslint'
O.lang.tsserver.autoformat = true

-- json
O.lang.json.autoformat = true
