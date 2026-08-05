{den, ...}: {

  den.aspects.coffee-machine = {
    nixos.imports = [../_nixos/hosts/coffee-machine/configuration.nix];
  };
}
