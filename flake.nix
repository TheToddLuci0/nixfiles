{
  description = "Home Manager configuration of notroot";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    #    nixvim = {
    #      url = "github:nix-community/nixvim";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix-unstable.url = "github:danth/stylix";
    #    nixvim-unstable = {
    #      url = "github:nix-community/nixvim";
    #      inputs.nixpkgs.follows = "nixpkgs-unstable";
    #    };
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
    systems.url = "github:nix-systems/default";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    den.url = "github:denful/den";
    import-tree.url = "github:denful/import-tree";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    let

      den =
        (inputs.nixpkgs.lib.evalModules {
          modules = [
            (inputs.import-tree ./modules)
            inputs.den.flakeOutputs.flake
          ];
          specialArgs.inputs = inputs;
        }).config;

      inherit (den.den.hosts.x86_64-linux) coffee-machine;
    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        # for `nix fmt`
        # formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
        # for `nix flake check`
        # checks = eachSystem (pkgs: {
        # formatting = treefmtEval.${pkgs.system}.config.build.check self;
        # });
        #    packages.${system}.ttl0-nvim =
        #      (
        #        nvf.lib.neovimConfiguration {
        #          pkgs = nixpkgs.legacyPackages.${system};
        #          modules = [./modules/nvf.nix];
        #        }
        #      ).neovim;
        flake = {
          systems = [ "x86_64-linux" ];
          imports = [
            # inputs.home-manager.flakeModules.home-manager
            # inputs.treefmt-nix.flakeModule
          ];
          homeConfigurations = {
            "notroot@work-nixos" = inputs.home-manager.lib.homeManagerConfiguration {
              # inherit pkgs;
              pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };

              # Specify your home configuration modules here, for example,
              # the path to your home.nix.
              modules = [
                inputs.nvf.homeManagerModules.default
                ./modules/_homes/work_notroot/home.nix
                inputs.stylix-unstable.homeModules.stylix
                # inputs.nixvim-unstable.homeModules.nixvim
                inputs.direnv-instant-unstable.homeModules.direnv-instant
              ];

              # Optionally use extraSpecialArgs
              # to pass through arguments to home.nix
            };
            "notroot@spaghetti-llc" = inputs.home-manager.lib.homeManagerConfiguration {
              #inherit pkgs;
              pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
              modules = [
                inputs.nvf.homeManagerModules.default
                ./modules/_homes/spaghetti-llc_notroot/home.nix
                inputs.stylix-unstable.homeModules.stylix
                #          inputs.nixvim-unstable.homeModules.nixvim
                inputs.direnv-instant-unstable.homeModules.direnv-instant
              ];
            };
            "notroot@coffee-machine" = inputs.home-manager.lib.homeManagerConfiguration {
              #inherit pkgs;
              pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
              modules = [
                inputs.nvf.homeManagerModules.default
                ./modules/_homes/coffee-machine_notroot/home.nix
                inputs.stylix-unstable.homeModules.stylix
                #          inputs.nixvim-unstable.homeModules.nixvim
                inputs.direnv-instant-unstable.homeModules.direnv-instant
              ];
            };
          };
          nixosConfigurations = {
            # Work nixos vm
            "work-nixos" = inputs.nixpkgs.lib.nixosSystem {
              modules = [
                ./modules/_nixos/hosts/work-nixos/configuration.nix
              ];
              # specialArgs = {
              #   pkgs-unstable = import inputs.nixpkgs-unstable {
              #     inherit system;
              #     config.allowUnfree = true;
              #   };
              # };
            };

            # Laptop 1
            "spaghetti-llc" = inputs.nixpkgs.lib.nixosSystem {
              # specialArgs = {inherit nixpkgs-gns3;};
              modules = [
                ./modules/_nixos/hosts/spaghetti-llc/configuration.nix
                # Known-good configs for laptops
                inputs.nixos-hardware.nixosModules.dell-xps-15-9570-nvidia
                inputs.nixos-rocksmith.nixosModules.default

                #          #Hacky nvf
                #          ({pkgs, ...}: {
                #            environment.systemPackages = [self.packages.${pkgs.stdenv.system}.ttl0-nvim];
                #          })
              ];
            };

            "coffee-machine" = inputs.nixpkgs.lib.nixosSystem {
              modules = [
                coffee-machine.mainModule
                #          ./nixos/hosts/coffee-machine/configuration.nix
              ];
            };
          };
        };
      }
    );
}
