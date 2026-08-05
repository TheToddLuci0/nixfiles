{den, ...}: {

  den.aspects.work-nixos = {
    nixos.imports = [../_nixos/hosts/work-nixos/configuration.nix];
  };
}
