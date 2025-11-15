{
  lib,
  config,
  pkgs,
  # pkgs-unstable,
  ...
}:

let
  cfg = config.ttl0.roles.gaming;
in
{
  options.ttl0.roles.gaming = {
    enable = lib.mkEnableOption "Enable gaming role";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [
        discord
    ];
  };
}