{
  description = "My developer mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [

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
            pkgs.dotnet-sdk_8
          ];

          homebrew = {
            enable = true;
            # Comment away after fully over on nix
            onActivation.cleanup = "uninstall";

            taps = [ ];
            brews = [
              "git-delta"
              "mas" # Mac App Store CLI
            ];
            casks = [
              "mongodb-compass"
            ];
            masApps = {
              "Things" = 904280696;
              "Greenshot" = 1103915944;
              "Messenger" = 1480068668;
            };
          };

          fonts.packages = with pkgs; [
            (nerdfonts.override {
              fonts = [
                "FiraCode"
                "JetBrainsMono"
                "Monaspace"
                "Hack"
              ];
            })
          ];
          system.defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            finder.AppleShowAllExtensions = true;
            finder.FXPreferredViewStyle = "clmv";
            screencapture.location = "~/Pictures/screenshots";
            screensaver.askForPasswordDelay = 10;
          };

          # necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          # programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 5;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          # Allow unfree software (needed for rider)
          nixpkgs.config.allowUnfree = true;

          # Use touch id for sudo authentication
          security.pam.enableSudoTouchIdAuth = true;

        };

    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Anders-Max
      darwinConfigurations."Anders-Max" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "andersns";

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
