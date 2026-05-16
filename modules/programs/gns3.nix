{
  self,
  ...
}: {
  # gns3 reqires that the client and server version match exactly. This effectively pins it to 2.2.55
  # I'm being lazy and importing it from a pinned nixpkgs rather than an overlay because it's hard
  # dependant on a bunch of qt stuff, and I don't want to spend three weeks debugging something I'll only be using for four.
  flake.homeModules.gns3-255 = {
    pkgs,
    ...
  }: {
    home.packages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.gns3-255
    ];
  };

  perSystem = {
    inputs',
    ...
  }: {
    packages.gns3-255 = inputs'.nixpkgs-gns3-255.legacyPackages.gns3-gui;
  };
}
