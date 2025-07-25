{
  description = "My developer mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-homebrew,
      sops-nix,
    }:
    let

      configuration =
        { pkgs, ... }:
        {
          nix.gc = {
            automatic = true;
            interval = {
              Hour = 3;
              Minute = 15;
              Weekday = 7; # Sunday
            };
            options = "--delete-older-than 7d";
          };

          environment.systemPackages = [ ];

          homebrew = {
            enable = true;
            onActivation.cleanup = "uninstall";

            taps = [ ];
            brews = [
              "git-delta"
              "openssl"
              "python"
              "pipx"
              "atuin"
              "git-spice"
            ];
            casks = [
              "mongodb-compass"
              "karabiner-elements"
              "raycast"
              "ghostty"
              "elgato-wave-link"
              "scroll-reverser"
              "spotify"
              "bruno"
            ];
          };

          fonts.packages = with pkgs; [
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
            nerd-fonts.monaspace
            nerd-fonts.hack
            nerd-fonts._3270

            # Maple Mono (Ligature TTF unhinted)
            maple-mono.truetype
            # Maple Mono NF (Ligature unhinted)
            maple-mono.NF-unhinted
            # Maple Mono NF CN (Ligature unhinted)
            maple-mono.NF-CN-unhinted
          ];

          system.defaults = {
            dock.autohide = true;
            dock.mru-spaces = false;
            screencapture.location = "~/Pictures/screenshots";

            NSGlobalDomain.KeyRepeat = 2;
            NSGlobalDomain.InitialKeyRepeat = 15;
            NSGlobalDomain."com.apple.sound.beep.volume" = 0.0;

            finder = {
              AppleShowAllExtensions = true;
              ShowPathbar = true;
              FXEnableExtensionChangeWarning = false;
              FXPreferredViewStyle = "clmv";
              ShowStatusBar = true;
            };
          };
          system.primaryUser = "andersns";
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

      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.andersns = import ./home.nix;
        home-manager.extraSpecialArgs = { inherit sops-nix; };
      };

      userSettings = {
        username = "andersns";
        darwinSystem = "aarch64-darwin";
        linuxSystem = "x86_64-linux";
      };
    in
    {
      homeConfigurations = {
        wsl = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { system = userSettings.linuxSystem; };
          extraSpecialArgs = {
            inherit inputs;
            inherit sops-nix;
          };
          modules = [
            ./home.nix
            {
              home = {
                username = userSettings.username;
              };
            }
          ];
        };
        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = userSettings.darwinSystem;
            config.allowUnfree = true;
          };
          extraSpecialArgs = homeManagerConfig.home-manager.extraSpecialArgs;
          modules = [
            ./home.nix
            {
              home = {
                username = userSettings.username;
              };
            }
          ];
        };
      };
      # Build darwin flake using:
      # $ sudo darwin-rebuild build --flake .#Anders-Max
      darwinConfigurations."Anders-Max" = nix-darwin.lib.darwinSystem {
        modules = [
          sops-nix.darwinModules.sops
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              user = userSettings.username;
              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          homeManagerConfig # Reuse the config here
          {
            users.users.${userSettings.username}.home = "/Users/andersns"; # TODO: Not sure if this is needed
          }
        ];
      };
    };
}
