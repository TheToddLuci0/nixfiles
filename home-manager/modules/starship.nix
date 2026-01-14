{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.programs.starship.enable {
    programs.starship = {
      # Configuration written to ~/.config/starship.toml
      settings = {
        "$schema" = "https://starship.rs/config-schema.json";
        # add_newline = false;
        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };
        # package.disabled = true;
      };
    };
  };
}