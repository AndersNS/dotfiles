{
  config,
  lib,
  ...
}:

{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  # sops.age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  sops.age.sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];

  sops.secrets = {
    "ANTHROPIC_API_KEY" = { };
  };

  programs.zsh.initContent = lib.mkAfter ''
    export ANTHROPIC_API_KEY=$(cat ${config.sops.secrets.ANTHROPIC_API_KEY.path})
  '';
}
