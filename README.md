# dotfiles

## Clone this repo

`git clone --bare git@github.com:AndersNS/dotfiles.git $HOME/.dotfiles`

## Set up alias

`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

### Hide untracked files

`dotfiles config --local status.showUntrackedFiles no`

### Check out the contents

`dotfiles checkout`

### Dotfiles Alias Usage

```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```

## Set up a new computer

### Install brew

Using the official installer:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Nix

Using the determinate installer:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

### Run darwin (macs)

```bash
 nix run nix-darwin -- switch --flake ~/.config/nix-darwin#Anders-Max
```

### Updating

```bash
nix flake update
```

### Home manager (linux)

```bash
nix run .#homeConfigurations.wsl.activationPackage
```

Then use:

```bash
home-manager switch --flake .#wsl
```

### Home secrets

Edit secretsfile

```bash
sops ~/.config/nix-darwin/secrets.yaml
```
