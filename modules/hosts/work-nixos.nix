{den, ...}: {

  den.aspects.work-nixos = {
    nixos = {pkgs, ...}:{
      imports = [../_nixos/hosts/work-nixos/configuration.nix];
        environment.systemPackages = [
          pkgs.s5cmd
          pkgs.pv
        ];
    };
  };
}
