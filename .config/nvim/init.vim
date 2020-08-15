set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" PLUGINS
" AutoInstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rust-lang/rust.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'alampros/vim-styled-jsx'
Plug 'gruvbox-community/gruvbox'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
Plug 'airblade/vim-rooter'
Plug 'alvan/vim-closetag'
Plug 'liuchengxu/vim-which-key'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sainnhe/gruvbox-material'
Plug 'easymotion/vim-easymotion'

call plug#end()

source $HOME/.config/nvim/general/settings.vim

source $HOME/.config/nvim/keybinds/keys.vim
source $HOME/.config/nvim/keybinds/whichkey.vim

source $HOME/.config/nvim/theme/airline.vim
" source $HOME/.config/nvim/theme/gruvbox.vim
source $HOME/.config/nvim/theme/gruvbox-material.vim
"source $HOME/.config/nvim/theme/nord.vim

source $HOME/.config/nvim/plug-configs/closetag.vim
source $HOME/.config/nvim/plug-configs/coc.vim
source $HOME/.config/nvim/plug-configs/easymotion.vim
source $HOME/.config/nvim/plug-configs/editorconfig.vim
source $HOME/.config/nvim/plug-configs/floaterm.vim
source $HOME/.config/nvim/plug-configs/fzf.vim
source $HOME/.config/nvim/plug-configs/commentary.vim
source $HOME/.config/nvim/plug-configs/rainbow.vim
source $HOME/.config/nvim/plug-configs/start-screen.vim

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point

if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
end


autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
