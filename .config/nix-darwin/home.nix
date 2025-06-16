{ lib, config, pkgs, sops-nix, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  homeDirectory = "/${if isDarwin then "Users" else "home"}/andersns";
in {
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";

  home.username = "andersns";
  home.homeDirectory = homeDirectory;

  home.packages = with pkgs;
    [
      # Terminal
      pkgs.alacritty
      pkgs.wezterm

      # Tmux
      pkgs.tmux
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.tmux-fzf
      pkgs.tmuxPlugins.fzf-tmux-url
      pkgs.tmuxifier

      # Terminal Utils
      pkgs.bash
      pkgs.bat
      pkgs.bat-extras.batman
      pkgs.bottom
      pkgs.zoxide
      pkgs.lsd
      pkgs.fzf
      pkgs.jq
      pkgs.ripgrep
      pkgs.neo-cowsay
      pkgs.tree
      pkgs.gnused
      pkgs.gnupg
      pkgs.tldr
      pkgs.fd # find

      # Zsh
      pkgs.oh-my-zsh

      # Editors
      pkgs.neovim

      # Tools
      pkgs.nixfmt-rfc-style
      pkgs.qmk
      pkgs.turso-cli
      pkgs.sops
      pkgs.age
      pkgs.ssh-to-age

      pkgs.postgresql

      # Git
      pkgs.git
      pkgs.lazygit
      pkgs.git-absorb
      pkgs.git-extras
      pkgs.diffsitter
      pkgs.difftastic
      pkgs.mergiraf
      pkgs.gh # GitHub CLI
      pkgs.glab # Gitlab CLI
      pkgs.git-ps-rs # https://git-ps.sh/

      # Containers
      pkgs.docker
      pkgs.docker-buildx
      pkgs.docker-compose
      pkgs.lazydocker
      pkgs.kubernetes-helm
      pkgs.k9s

      pkgs.azure-cli
      # pkgs.terraform

      # Rice
      pkgs.starship

      # Frontend
      pkgs.nodejs_20
      pkgs.bun
      pkgs.pnpm
      pkgs.yarn

      # Languages
      pkgs.go
      pkgs.libllvm
      pkgs.luajitPackages.luacheck
      pkgs.rustup
      pkgs.cargo-binstall

    ] ++ lib.optionals isDarwin [
      pkgs.jetbrains.rider
      pkgs.obsidian

      pkgs.colima

      # Utils
      pkgs.karabiner-elements
      pkgs.hidden-bar

      pkgs.aerospace
      pkgs.jankyborders
      pkgs.sketchybar
    ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  imports = [ sops-nix.homeManagerModules.sops ./home-secrets.nix ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = ''
      source $HOME/.aliases

      eval "$(atuin init zsh)"

      if [[ -n "$SOPS_SECRETS_DIR" ]]; then
        export api_token=$(<"$SOPS_SECRETS_DIR/api_token")
      fi
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "unixorn/fzf-zsh-plugin"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "wfxr/forgit"; }
      ];
    };
    envExtra = ''
      export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"

      export PATH="$HOME/.tmuxifier/bin:$PATH"
      export PATH="$PATH:~/scripts/"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/Library/Python/3.9/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
      export GOPATH="$HOME/go"
      export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
      export PATH="$PATH:/usr/local/share/dotnet"
      export PATH="$PATH:/Users/andersns/.dotnet/tools"

      export PATH="$PATH:$ZPLUG_HOME/repos/wfxr/forgit/bin"
      export PATH="$PATH:$HOME/.cache/npm/global/bin"
      export FORGIT_LOG_FORMAT="%C(auto)%h%d %s %C(cyan)%C(dim)%cr%Creset"

      export EDITOR="nvim"
      export XDG_CONFIG_HOME="$HOME/.config"
      # bindkey "ç" fzf-cd-widget
      export WALK_EDITOR=nvim
      ${if isDarwin then
        "export DOCKER_HOST=unix:///$HOME/.config/colima/default/docker.sock"
      else
        ""}
    '';

    oh-my-zsh = {
      enable = true;
      plugins =
        [ "aliases" "git" "fzf" "docker" "docker-compose" "kubectl" "tmux" ];
    };
  };

  home.activation = {
    installtmp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Install or update tmux package manager (TPM)
      dir='$HOME/.tmux/plugins/tpm'
      repo='https://github.com/tmux-plugins/tpm'

      if [ -d "$dir/.git" ]; then
        ${pkgs.git}/bin/git -C "$dir" pull --ff-only
      else
        ${pkgs.git}/bin/git clone "$repo" "$dir"
      fi

      # Fix for npm global packages
      if [ ! -d '$HOME/.cache/npm/global' ]; then
        ${pkgs.nodejs_20}/bin/npm config set prefix "$HOME/.cache/npm/global"
        mkdir -p "$HOME/.cache/npm/global" 
      fi
    '';
  };
}
