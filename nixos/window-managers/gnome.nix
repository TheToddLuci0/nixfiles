{config, pkgs, lib, ...}:

let
  cfg = config.ttl0.windowManagers.gnome;
in
{
  options = {
    ttl0.windowManagers.gnome.enable = lib.mkEnableOption "Enable GNOME";
  };

  config = lib.mkIf cfg.enable {
    # from autogen configuration.nix
  
    # Enable the X11 windowing system
    services.xserver.enable = true;
  
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
