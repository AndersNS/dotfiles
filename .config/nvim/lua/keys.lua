vim.api.nvim_set_keymap('n', '-', ':RnvimrToggle<CR>', {noremap = true, silent = true})

-- better window movement
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h <CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j <CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k <CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l <CR>', {silent = true})

-- Terminal window navigation
vim.cmd([[
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l
  inoremap <C-h> <C-\><C-N><C-w>h
  inoremap <C-j> <C-\><C-N><C-w>j
  inoremap <C-k> <C-\><C-N><C-w>k
  inoremap <C-l> <C-\><C-N><C-w>l
  tnoremap <Esc> <C-\><C-n>
]])

vim.cmd('inoremap <expr> <c-j> (\"\\<C-n>\")')
vim.cmd('inoremap <expr> <c-k> (\"\\<C-p>\")')

vim.cmd('vnoremap p "0p')
vim.cmd('vnoremap P "0P')

-- better indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})

-- Tab switch buffer
vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- Save
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true, silent = true})

-- Toggle the QuickFix window
vim.api.nvim_set_keymap('', '<C-q>', ':call QuickFixToggle()<CR>', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', 'kj', '<ESC>', {noremap = true, silent = true})

-- nvim-compe key map
vim.cmd('inoremap <silent><expr> <C-Space> compe#complete()')
vim.cmd("inoremap <silent><expr> <CR>      compe#confirm('<CR>')")
vim.cmd("inoremap <silent><expr> <C-e>     compe#close('<C-e>')")
vim.cmd("inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })")
vim.cmd("inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })")

-- resize with arrows
vim.api.nvim_set_keymap('n', '<M-j>', ':resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<M-k>', ':resize +2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<M-h>', ':vertical resize -2<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<M-l>', ':vertical resize +2<CR>', {silent = true})
