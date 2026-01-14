{config, lib, ...}:

{
  config = lib.mkIf config.wayland.windowManager.hyprland.enable {
    programs.kitty.enable = true; # required for base hyprland
#    wayland.windowManager.hyprland.enable = true; # Turn on hypr
    wayland.windowManager.hyprland.systemd.variables = [ "--all" ];
    wayland.windowManager.hyprland.package = null;
#    wayland.windowManager.hyprland.portalPackage = null;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      bind = [
        "$mod, Q, exec, $terminal"
      ];
    };
    
  };
}
