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

    # Utils
    pkgs.karabiner-elements
    pkgs.hidden-bar

    # Zsh
    pkgs.oh-my-zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-completions
    pkgs.zsh-syntax-highlighting

    # Editors
    pkgs.jetbrains.rider
    pkgs.neovim
    pkgs.obsidian

    # Tools
    pkgs.nixfmt-rfc-style
    pkgs.openssl
    pkgs.qmk
    pkgs.turso-cli

    # Git
    pkgs.git
    pkgs.lazygit
    pkgs.git-absorb
    pkgs.git-extras
    pkgs.diffsitter
    pkgs.difftastic
    pkgs.gh # GitHub CLI

    # Containers
    pkgs.colima
    pkgs.docker
    pkgs.docker-compose
    pkgs.lazydocker
    pkgs.kubernetes-helm
    pkgs.k9s

    pkgs.azure-cli

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
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        (sdk_9_0.overrideAttrs (oldAttrs: {
          version = "9.0.100";
        }))
      ]
    )
  ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initExtra = ''
      source $HOME/.aliases
    '';
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "unixorn/fzf-zsh-plugin"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
    envExtra = ''
      export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden"

      export PATH="$HOME/.tmuxifier/bin:$PATH"
      export PATH="$PATH:~/scripts/"
      export GOPATH="$HOME/go"
      export EDITOR="nvim"
      export XDG_CONFIG_HOME="$HOME/.config"

      # bindkey "ç" fzf-cd-widget
      export WALK_EDITOR=nvim
      export DOCKER_HOST='unix://$HOME/.colima/docker.sock'
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
