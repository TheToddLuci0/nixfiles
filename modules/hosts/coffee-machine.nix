{den, ...}: {
  den.aspects.coffee-machine = {
    includes = [
      den.batteries.hostname
      den.aspects.gaming
    ];
    nixos = _: {};
  };
}
