{
  den,
  inputs,
  ...
}:
{

  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.stylix = {

    nixos = { pkgs, lib, ... }: {
      imports = [ inputs.stylix.nixosModules.stylix ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
        image = lib.mkDefault ../../assets/wallpapers/default.png;
        polarity = "dark";
      };
    };

    homeManager = { pkgs, lib, ... }: {
      imports = [ (inputs.stylix.homeModules.stylix) ];
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
        # targets.kitty.enable = true;
        autoEnable = true;
        polarity = "dark";
        targets.vscode.enable = false;
        # Wallpaper
        image = lib.mkDefault ../../assets/wallpapers/default.png; # TODO: Is there a better way to resolve this path?
      };
      # TODO: Does this belong in a provides or somethings?
      # If we're not using gnome, will this cause gnome things to be pulled in?
      dconf.settings."org/gnome/shell".enabledExtensions = [
        "pkgs.gnomeExtensions.user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
  };
}
