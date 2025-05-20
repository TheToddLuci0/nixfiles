{
  config,
  pkgs,
  lib,
  # stylix,
  ...
}:
{
  stylix = {
    enable = true;
    # Automatically generate the background based on the theme
    # image = config.lib.stylix.pixel "base0A";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/shadesmear-dark.yaml";
    # Don't style kitty, that's being done manualy
    targets.kitty.enable = false;
    autoEnable = true;
    polarity = "dark";
    targets.vscode.enable = false;
  };
}
