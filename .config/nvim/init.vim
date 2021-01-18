set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source $HOME/.config/nvim/plugins/plug.vim
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keybinds/keys.vim

source $HOME/.config/nvim/plug-configs/easymotion.vim

if exists('g:vscode')
  source $HOME/.config/nvim/vscode/settings.vim
  source $HOME/.config/nvim/vscode/highlightyank.vim
else
  source $HOME/.config/nvim/theme/airline.vim
  " source $HOME/.config/nvim/theme/gruvbox.vim
  " source $HOME/.config/nvim/theme/gruvbox-material.vim
   source $HOME/.config/nvim/theme/nord.vim
  " source $HOME/.config/nvim/theme/material.vim

  source $HOME/.config/nvim/plug-configs/closetag.vim
  source $HOME/.config/nvim/plug-configs/coc.vim
  source $HOME/.config/nvim/plug-configs/easymotion.vim
  source $HOME/.config/nvim/plug-configs/editorconfig.vim
  source $HOME/.config/nvim/plug-configs/far.vim
  source $HOME/.config/nvim/plug-configs/floaterm.vim
  source $HOME/.config/nvim/plug-configs/fzf.vim
  source $HOME/.config/nvim/plug-configs/commentary.vim
  source $HOME/.config/nvim/plug-configs/rainbow.vim
  source $HOME/.config/nvim/plug-configs/start-screen.vim
  source $HOME/.config/nvim/plug-configs/markdown-preview.vim

  source $HOME/.config/nvim/general/neovide.vim

  source $HOME/.config/nvim/keybinds/whichkey.vim
endif


" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point

if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
end


autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
