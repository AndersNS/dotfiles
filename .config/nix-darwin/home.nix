{ config, pkgs, ... }:

rec {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # TODO: ??

  home.username = "andersns";
  home.homeDirectory = "/Users/andersns";

  home.packages = with pkgs; [
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
