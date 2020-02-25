# dotfiles

## Set up a new computer
### Install Nerd Fonts
I use Fura Code NF from https://github.com/ryanoasis/nerd-fonts

### Clone the repo
`git clone --bare git@github.com:AndersNS/dotfiles.git $HOME/.dotfiles`

### Install the zsh theme:

`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

### Install SpaceVim
`curl -sLf https://spacevim.org/install.sh | bash`

### Set up alias
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

### Hide untracked files
`dotfiles config --local status.showUntrackedFiles no`

### Check out the contents
`dotfiles checkout`


> If you already have some of the files you'll get an error. Delete them or something. 


## Alias Usage
```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```
