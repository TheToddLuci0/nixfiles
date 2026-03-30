{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.ttl0.roles.azure;
in {
  options.ttl0.roles.azure = {
    enable = lib.mkEnableOption "Enable assorted azure things.";
  };

  config = lib.mkIf cfg.enable {
    # A place for all the cursed azure things. I hate everything about it.
    home.packages = with pkgs; [
      azure-storage-azcopy
      azure-cli
      powershell
    ];

    services.remmina = {
      # I hate RDP most of all, but ya gotta have it
      enable = true;
      systemdService.enable = false;
    };
  };
}
