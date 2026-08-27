{den, inputs, ...}: {

  den.aspects.spaghetti-llc = {
    nixos.imports = [
      ../_nixos/hosts/spaghetti-llc/configuration.nix
      inputs.nixos-hardware.nixosModules.dell-xps-15-9570-nvidia
    ];
  };
}
