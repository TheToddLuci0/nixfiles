{den, inputs, ...}: {

  den.aspects.toaster-oven = {
    includes = [
      den.batteries.hostname
      den.aspects.gnome
      den.aspects.dev
      den.aspects.dev.docker
      den.aspects.gaming
      den.aspects.flipper
      den.aspects.nix-locate
      den.aspects.niri
      den.aspects.notroot.provides.to-hosts
     ];
    nixos = {pkgs, ...}:{
      imports = [
        ./_nixos/configuration.nix
	(inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen)
      ];
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      programs.nh.flake = "/home/notroot/git/nixfiles";
      services.fprintd.enable = true;
      hardware.onlykey.enable = true;
      networking.wg-quick.interfaces.wg0 = {
        configFile = "/etc/nixos/files/wireguard/wg0.conf";
        autostart = false;
      };
      programs.nh.clean = {
        enable = true;
        dates = "weekly";
        # This thing has a small little disk, so let's be a bit more aggressive.
        extraArgs = "--keep 2 --keep-since 3d --keep-one --optimize";
      };
    };
  };
}
