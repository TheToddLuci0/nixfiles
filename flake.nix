{
  description = "Home Manager configuration of notroot";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix-unstable.url = "github:danth/stylix";
    direnv-instant-unstable = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-rocksmith = {
      url = "github:re1n0/nixos-rocksmith";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixpkgs-gns3-255 = {
      url = "github:nixos/nixpkgs?ref=01951bed8cbe0ca5607a9651f2544b260963ec76";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    flake-parts,
    home-manager,
    nixpkgs,
    nixpkgs-gns3-255,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        inputs.home-manager.flakeModules.home-manager
        inputs.treefmt-nix.flakeModule
      ];

      perSystem = _: {
        treefmt = {
          # Used to find the project root
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };
      };

      flake = {
        homeConfigurations = {
          "notroot@work-nixos" = home-manager.lib.homeManagerConfiguration {
            # inherit pkgs;
            pkgs = import nixpkgs {system = "x86_64-linux";};

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [
              inputs.nvf.homeManagerModules.default
              ./home-manager/work_notroot/home.nix
              inputs.stylix-unstable.homeModules.stylix
              # inputs.nixvim-unstable.homeModules.nixvim
              inputs.direnv-instant-unstable.homeModules.direnv-instant
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
          };
          "notroot@spaghetti-llc" = home-manager.lib.homeManagerConfiguration {
            # inherit pkgs;
            pkgs = import nixpkgs {system = "x86_64-linux";};
            modules = [
              inputs.nvf.homeManagerModules.default
              ./home-manager/spaghetti-llc_notroot/home.nix
              inputs.stylix-unstable.homeModules.stylix
              #          inputs.nixvim-unstable.homeModules.nixvim
              inputs.direnv-instant-unstable.homeModules.direnv-instant
            ];
          };
          "notroot@coffee-machine" = home-manager.lib.homeManagerConfiguration {
            # inherit pkgs;
            pkgs = import nixpkgs {system = "x86_64-linux";};
            modules = [
              inputs.nvf.homeManagerModules.default
              ./home-manager/coffee-machine_notroot/home.nix
              inputs.stylix-unstable.homeModules.stylix
              #          inputs.nixvim-unstable.homeModules.nixvim
              inputs.direnv-instant-unstable.homeModules.direnv-instant
            ];
          };
        };
        nixosConfigurations = {
          # Work nixos vm
          "work-nixos" = nixpkgs.lib.nixosSystem {
            # inherit system;
            modules = [
              ./nixos/hosts/work-nixos/configuration.nix
            ];
            # specialArgs = {
            #   pkgs-unstable = import inputs.nixpkgs {
            #     inherit system;
            #     config.allowUnfree = true;
            #   };
            # };
          };

          # Laptop 1
          "spaghetti-llc" = nixpkgs.lib.nixosSystem {
            # inherit system;
            specialArgs = {inherit nixpkgs-gns3-255;};
            modules = [
              ./nixos/hosts/spaghetti-llc/configuration.nix
              # Known-good configs for laptops
              inputs.nixos-hardware.nixosModules.dell-xps-15-9570-nvidia
              inputs.nixos-rocksmith.nixosModules.default

              #          #Hacky nvf
              #          ({pkgs, ...}: {
              #            environment.systemPackages = [self.packages.${pkgs.stdenv.system}.ttl0-nvim];
              #          })
            ];
          };

          "coffee-machine" = nixpkgs.lib.nixosSystem {
            # inherit system;
            modules = [
              ./nixos/hosts/coffee-machine/configuration.nix
            ];
          };
        };
      };
    };
}
