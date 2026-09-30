{ inputs, den, ... }: {

  flake-file.inputs.noctalia = {
    url = "github:noctalia-dev/noctalia";
    inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
  };

  den.aspects.niri = {

    nixos = { pkgs, ... }: {
      imports = [ (inputs.noctalia.nixosModules.default) ];
      programs.niri.enable = true;
      systemd.user.services.niri.enableDefaultPath = false;
      security.polkit.enable = true;
      services.gnome.gnome-keyring.enable = true; # secret service
      security.pam.services.swaylock = { };

      # programs.waybar.enable = true; # top bar
      # environment.systemPackages = with pkgs; [
      #   waybar
      #   kitty
      #   fuzzel
      #   swaylock
      #   mako
      #   swayidle
      #   xwayland-satellite # xwayland support
      # ];

      programs.noctalia = {
        enable = true;
        # systemd.enable = true;

        # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
        recommendedServices.enable = true;
      };

      services.displayManager.noctalia-greeter = {
        enable = true;
        # settings = {
        #   cursor.size = 24;
        #   keyboard.layout = "us";
        # };
        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
        };
      };
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.noctalia.homeModules.default
      ];
    
      programs.fuzzel.enable = true;
      services.mako = {
        enable = true;
        settings = {
          default-timeout = 1500;
        };
      };
      programs.kitty.enable = true;
      services.polkit-gnome.enable = true;
      # programs.waybar.enable = true;
      # programs.waybar.systemd.enable = false;

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };
    };

  };

}
