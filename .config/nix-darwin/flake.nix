{
  description = "My developer mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          environment.systemPackages = [ ];

          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";

            taps = [ ];
            brews = [
              "git-delta"
              "openssl"
              "mas" # Mac App Store CLI
              "python"
              "pipx"
            ];
            casks = [
              "mongodb-compass"
              "karabiner-elements"
              "raycast"
              "ghostty"
            ];
            masApps = {
              "Things" = 904280696;
              "Greenshot" = 1103915944;
              "Messenger" = 1480068668;
            };
          };

          fonts.packages = [
            pkgs.nerd-fonts.fira-code
            pkgs.nerd-fonts.jetbrains-mono
            pkgs.nerd-fonts.monaspace
            pkgs.nerd-fonts.hack
          ];

          system.defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            finder.AppleShowAllExtensions = true;
            finder.FXPreferredViewStyle = "clmv";
            screencapture.location = "~/Pictures/screenshots";

            NSGlobalDomain.KeyRepeat = 2;
            NSGlobalDomain.InitialKeyRepeat = 15;
            NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;
          };

          system.keyboard.enableKeyMapping = true;
          system.keyboard.remapCapsLockToControl = true;
          system.startup.chime = false;

          # necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.optimise.automatic = true;

          # Enable alternative shell support in nix-darwin.
          programs.zsh.enable = true;

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
          security.pam.services.sudo_local.touchIdAuth = true;
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
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              user = "andersns";

              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.andersns = import ./home.nix;
            users.users.andersns.home = "/Users/andersns"; # TODO: Not sure why this is needed
          }
        ];
      };
    };
}
