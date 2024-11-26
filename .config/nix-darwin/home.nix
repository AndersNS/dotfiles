{ config, pkgs, ... }:

rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # TODO: ??

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
    pkgs.raycast
    pkgs.karabiner-elements
    pkgs.hidden-bar

    # Zsh
    pkgs.oh-my-zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-completions
    pkgs.zsh-syntax-highlighting
    pkgs.fzf-zsh

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

    # Languages
    pkgs.go
    pkgs.libllvm
    pkgs.luajitPackages.luacheck
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

}
