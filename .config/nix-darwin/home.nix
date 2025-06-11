{ config, pkgs, ... }:

rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";

  home.username = "andersns";
  home.homeDirectory = "/Users/andersns";

  home.packages = with pkgs; [
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

    # Utils
    pkgs.karabiner-elements
    pkgs.hidden-bar

    # Zsh
    pkgs.oh-my-zsh

    # Editors
    pkgs.jetbrains.rider
    pkgs.neovim
    pkgs.obsidian

    # Tools
    pkgs.nixfmt-rfc-style
    pkgs.qmk
    pkgs.turso-cli

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
    pkgs.colima
    pkgs.docker
    pkgs.docker-buildx
    pkgs.docker-compose
    pkgs.lazydocker
    pkgs.kubernetes-helm
    pkgs.k9s

    pkgs.azure-cli
    # pkgs.terraform

    # Rice
    pkgs.aerospace
    pkgs.jankyborders
    pkgs.sketchybar
    pkgs.starship

    # Frontend
    pkgs.nodejs_20
    pkgs.pnpm
    pkgs.yarn

    # Languages
    pkgs.go
    pkgs.libllvm
    pkgs.luajitPackages.luacheck
    pkgs.rustup
    pkgs.cargo-binstall

  ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = ''
      source $HOME/.aliases

      eval "$(atuin init zsh)"
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
      export PATH="/Users/andersns/Library/Python/3.9/bin:$PATH"
      export PATH="/Users/andersns/.local/bin:$PATH"
      export GOPATH="$HOME/go"
      export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
      export PATH="$PATH:/usr/local/share/dotnet"
      export PATH="$PATH:/Users/andersns/.dotnet/tools"

      export EDITOR="nvim"
      export XDG_CONFIG_HOME="$HOME/.config"
      # bindkey "ç" fzf-cd-widget
      export WALK_EDITOR=nvim
      export DOCKER_HOST=unix:///$HOME/.config/colima/default/docker.sock
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "aliases"
        "git"
        "fzf"
        "docker"
        "docker-compose"
        "kubectl"
        "tmux"
      ];
    };
  };
}
