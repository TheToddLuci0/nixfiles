{ self, inputs, ... }: {
  flake.homeModules.gns3-255 = {pkgs, lib, inputs, ... }: {
    home.packages = [
      inputs.nixpkgs-gns3-255.legacyPackages.gns3-gui 
      pkgs.hello 
    ];
  };
}