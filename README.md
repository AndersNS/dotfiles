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


# Vim Keybindings

Exit insert mode `jj`

## Buffers & Windows
Window left: `<leader> wh` 

Window down: `<leader> wj` 

Window up: `<leader> wk` 

Window right: `<leader> wl` 

Split horizontal: `<leader> ws` 

Split vertical: `<leader> wv` 

Vertical resize +: `<leader> +`

Vertical resize -: `<leader> -`



Make this window the only one: `<leader> wo`
Close buffer: `<leader> qq`


View buffers: `<leader> bb`


## Files
Open file tree: `<leader> ft`

Reveal current buffer in file tree: `<leader> pv`


Find files: `<leader> pf`

Find files in git: `<leader> pg`

## Completion
Trigger completion `<C-space>`


Go to definition: `<leader> gd`

Go to type definition: `<leader> gy`

Go to implementation: `<leader> gi`

View references: `<leader> gr`

Rename: `<leader> rr`

Previous error: `<leader> gp`

Next error: `<leader> gn`


View quick fixes: `<leader> qf`


View documentation: `K`
<!--stackedit_data:
eyJwcm9wZXJ0aWVzIjoiZXh0ZW5zaW9uczpcbiAgcHJlc2V0Oi
BnZm1cbiIsImhpc3RvcnkiOls5MTY2MTc4MjVdfQ==
-->
