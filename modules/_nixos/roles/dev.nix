{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.ttl0.roles.dev;
in {
  options.ttl0.roles.dev = {
    enable = lib.mkEnableOption "Enable dev role";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      python3
      git
      gnumake
      rustup
      gcc
    ];
  };
}
