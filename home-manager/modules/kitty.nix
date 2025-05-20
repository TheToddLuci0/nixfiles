{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.programs.kitty.enable {
    programs.kitty = {
      font = {
        inherit (config.stylix.fonts.monospace) package name;
        size = config.stylix.fonts.sizes.terminal;
      };
      settings = {
        enable_audio_bell = false;
        tab_bar_style = "fade";
        tab_powerline_style = "round";
        active_tab_foreground = "#8059ff";
        active_tab_background = "#000";
        background = "#232323";
        foreground = "#dbdbdb";
        selection_background = "#dbdbdb";
        selection_foreground = "#232323";
        url_color = "#e4e4e4";
        cursor = "#dbdbdb";
        active_border_color = "#c0c0c0";
        inactive_border_color = "#1c1c1c";
        #active_tab_background = "#232323";
        #active_tab_foreground = "#dbdbdb";
        inactive_tab_background = "#1c1c1c";
        inactive_tab_foreground = "#e4e4e4";
        tab_bar_background = "#1c1c1c";
        wayland_titlebar_color = "#232323";
        
        # normal
        color0 = "#232323";
        color1 = "#cc5450";
        color2 = "#71983b";
        color3 = "#307878";
        color4 = "#376388";
        color5 = "#d7ab54";
        color6 = "#c57d42";
        color7 = "#dbdbdb";
        
        # bright
        color8 = "#c0c0c0";
        color9 = "#a64270";
        color10 = "#1c1c1c";
        color11 = "#4e4e4e";
        color12 = "#e4e4e4";
        color13 = "#e4e4e4";
        color14 = "#6d6d6d";
        color15 = "#1c1c1c";
      };
    };
  };
}
