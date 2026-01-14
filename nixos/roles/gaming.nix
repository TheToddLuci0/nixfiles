{
  lib,
  config,
  pkgs,
  # pkgs-unstable,
  ...
}: let
  cfg = config.ttl0.roles.gaming;
in {
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
      helvum # Lets you view pipewire graph and connect IOs
      rtaudio
    ];

    # systemd.user.timers."kill-discord" = {
    #   # Discord has a bug where it doesn't send notifications to phones if you're logged in. So, we kill it. :)
    #   Unit = {
    #     Description = "Kill discord.";
    #     Type = "oneshot";
    #     ExecStart = "sh -c 'pgrep Discord | xargs kill'";
    #   };
    #   Timer = {
    #     OnCalendar = "*-*-* 00:00:00";
    #   };
    # };
  };
}
