{
  description = "Home Manager configuration of notroot";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations = {
        "notroot@desktop-nixos-vm" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # imports = [ inputs.nixvim.homeManagerModules.nixvim ];

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home-manager/desktop_vm_notroot/home.nix
            inputs.nixvim.homeManagerModules.nixvim
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
        "notroot@work-nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
	    ./home-manager/work_notroot/home.nix
            inputs.nixvim.homeManagerModules.nixvim
	    ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
      nixosConfigurations = {
        "desktop-nixos-vm" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./nixos/hosts/desktop-nixos-vm/configuration.nix ];
        };
        # Work nixos vm
        "work-nixos" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/hosts/work-nixos/configuration.nix
          ];
          specialArgs = {
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
      };
    };
}
