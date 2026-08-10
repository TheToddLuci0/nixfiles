{ den, ... }: {
  den.aspects.flipper = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.qFlipper ];
      hardware.flipperzero.enable = true;
    };
  };
}
