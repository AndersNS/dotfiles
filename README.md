# dotfiles

## Set up a new computer

### Install Nerd Fonts

I use Fura Code NF from https://www.nerdfonts.com/

### Clone this repo

`git clone --bare git@github.com:AndersNS/dotfiles.git $HOME/.dotfiles`

### Install Oh My Zsh

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Install the zsh theme:

`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

### Install Oh My Zsh plugins

Autosuggestions:

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

Syntax highlighting

`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

### Set up alias

`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

### Hide untracked files

`dotfiles config --local status.showUntrackedFiles no`

### Check out the contents

`dotfiles checkout`

> If you already have some of the files you'll get an error. Delete them or something.

### Set up vim

1. Open a vim file
2. (Should happen automatically) Install plugins `:PlugInstall`
3. (Should happen automatically) Install CocServers `:CocInstall coc-json coc-tsserver coc-css coc-omnisharp`

# Dotfiles Alias Usage

```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```
