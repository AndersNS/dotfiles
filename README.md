# dotfiles

## Set up a new computer
### Install Nerd Fonts
I use Fura Code NF from https://www.nerdfonts.com/

### Clone the repo
`git clone --bare git@github.com:AndersNS/dotfiles.git $HOME/.dotfiles`

### Install the zsh theme:

`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

### Set up alias
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

### Hide untracked files
`dotfiles config --local status.showUntrackedFiles no`

### Check out the contents
`dotfiles checkout`

> If you already have some of the files you'll get an error. Delete them or something. 

### Set up vim
1. Open a vim file
2. Install plugins `:PlugInstall`
3. Install YouCompleteMe
```
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer


```



## Alias Usage
```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```
