# dotfiles

## Set up a new computer
### Clone the repo
`git clone --bare git@github.com:AndersNS/dotfiles.git $HOME/.dotfiles`

### Set up alias
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

### Check out the contents
`dotfiles checkout`


> If you already have some files you'll get an error message. Delete them or something. 


## Usage
```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```
