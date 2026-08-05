{den, ...}: {

  den.aspects.spaghetti-llc = {
    nixos.imports = [../_nixos/hosts/spaghetti-llc/configuration.nix];
  };
}
