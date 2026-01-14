{
  config,
  pkgs,
  lib,
  ...
}:
# Completely untested, can't get 3d accelerated graphics working on test VM
# Largely based on https://www.youtube.com/watch?v=61wGzIv12Ds
let
  cfg = config.ttl0.windowManagers.hyprland;
in {
  options = {
    ttl0.windowManagers.hyprland = {
      enable = lib.mkEnableOption "Enable HyprLand";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    hardware = {
      opengl.enable = true;
    };
    environment.sessionVariables = {
      # Enable if cursors are gone
      # WLR_NO_HARDWARE_CURSORS = "1";
      # Hint to electron that we're using wayland
      NIXOS_OZONE_WL = "1";
    };
    # Minimal packages. The rest should be handled by home manager
    environment.systemPackages = with pkgs; [
      kitty # terminal
      ghostty
      #      waybar # bar
      #      mako # Notifier
      #      rofi-wayland # launcher
    ];
  };
}
