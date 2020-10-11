" PLUGINS
" AutoInstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" :PlugInstall to install plugins
call plug#begin('~/.vim/plugged')

  Plug 'tpope/vim-commentary'

  if exists ('g:vscode')
    Plug 'asvetliakov/vim-easymotion'
    Plug 'machakann/vim-highlightedyank'
  else
    Plug 'tpope/vim-surround'
    Plug 'voldikss/vim-floaterm'
    Plug 'mhinz/vim-startify'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
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
    Plug 'junegunn/goyo.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'sainnhe/gruvbox-material'
    Plug 'easymotion/vim-easymotion'
    Plug 'brooth/far.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
    Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  endif



call plug#end()
