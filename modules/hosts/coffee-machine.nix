{den, ...}: {
  den.aspects.coffee-machine = {
    includes = [
      den.batteries.hostname
      den.aspects.gaming
      # den.aspects.nvf
    ];
    nixos = _: {
        imports = [
          ../_nixos/hosts/coffee-machine/configuration.nix
        ];
    };
  };
}
