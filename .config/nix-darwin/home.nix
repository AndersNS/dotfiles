{
  lib,
  _config,
  pkgs,
  sops-nix,
  ...
}:

let
  isDarwin = pkgs.stdenv.isDarwin;
  homeDirectory = "/${if isDarwin then "Users" else "home"}/andersns";
in
{
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";
  home.homeDirectory = homeDirectory;

  home.packages =
    with pkgs;
    [
      # Terminal
      alacritty
      wezterm

      # Tmux
      tmux
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
      tmuxifier

      # Terminal Utils
      bash
      bat
      bat-extras.batman
      bottom
      zoxide
      lsd
      fzf
      jq
      ripgrep
      neo-cowsay
      tree
      gnused
      gnupg
      tldr
      fd # find
      yazi

      # Zsh
      oh-my-zsh

      # Editors
      neovim

      tree-sitter

      # Tools
      nixfmt-rfc-style
      statix
      qmk
      turso-cli
      sops
      age
      ssh-to-age

      # Databases
      postgresql

      # Git
      git
      lazygit
      git-absorb
      git-extras
      diffsitter
      difftastic
      mergiraf
      gh # GitHub CLI
      glab # Gitlab CLI
      git-ps-rs # https://git-ps.sh/
      # TODO: add this back git-spice

      # Containers
      docker
      docker-buildx
      docker-compose
      lazydocker
      kubernetes-helm
      k9s

      azure-cli
      # terraform

      # Rice
      starship

      # Frontend
      nodejs_22
      bun
      pnpm
      yarn

      # Languages
      go
      libllvm
      luajitPackages.luacheck
      rustup
      cargo-binstall
      nil

    ]
    ++ lib.optionals isDarwin [
      jetbrains.rider
      obsidian

      colima

      # Utils
      karabiner-elements
      hidden-bar

      aerospace
      jankyborders
      sketchybar
    ];

  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.bottom.enable = true;

  imports = [
    sops-nix.homeManagerModules.sops
    ./home-secrets.nix
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = ''
      source $HOME/.aliases

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
      export PATH="$HOME/.bun/bin:$PATH"
      export FORGIT_LOG_FORMAT="%C(auto)%h%d %s %C(cyan)%C(dim)%cr%Creset"

      export EDITOR="nvim"
      export XDG_CONFIG_HOME="$HOME/.config"
      # bindkey "ç" fzf-cd-widget
      export WALK_EDITOR=nvim
      ${
        if isDarwin then
          ''

            export DOCKER_HOST=unix:///$HOME/.config/colima/default/docker.sock
            export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
            export TESTCONTAINERS_HOST_OVERRIDE=$(colima ls -j | jq -r '.address')
          ''
        else
          ""
      }

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

  home.activation = {
    installtmp = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      # At this point, PATH should be set up
      PATH="${homeDirectory}/.nix-profile/bin:$PATH"

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


      # Install yazi packages
      ya pkg install
    '';
  };
}
