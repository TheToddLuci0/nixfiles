{den, ...}: {

  den.aspects.work-nixos = {
    includes = [
      den.aspects.gnome
    ];
    nixos = {pkgs, ...}:{
      imports = [../_nixos/hosts/work-nixos/configuration.nix];
      virtualisation.vmware.guest.enable = true;
        environment.systemPackages = [
          pkgs.s5cmd
          pkgs.pv
          pkgs.tor-browser
        ];
    };
  };
}
