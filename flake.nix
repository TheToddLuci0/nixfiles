{
  description = "Home Manager configuration of notroot";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #    nixvim = {
    #      url = "github:nix-community/nixvim";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    stylix-unstable.url = "github:danth/stylix";
    #    nixvim-unstable = {
    #      url = "github:nix-community/nixvim";
    #      inputs.nixpkgs.follows = "nixpkgs-unstable";
    #    };
    direnv-instant-unstable = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-rocksmith = {
      url = "github:re1n0/nixos-rocksmith";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager-unstable,
    treefmt-nix,
    systems,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});
    treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    # for `nix fmt`
    formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
    # for `nix flake check`
    checks = eachSystem (pkgs: {
      formatting = treefmtEval.${pkgs.system}.config.build.check self;
    });
    #    packages.${system}.ttl0-nvim =
    #      (
    #        nvf.lib.neovimConfiguration {
    #          pkgs = nixpkgs.legacyPackages.${system};
    #          modules = [./modules/nvf.nix];
    #        }
    #      ).neovim;
    homeConfigurations = {
      "notroot@work-nixos" = home-manager-unstable.lib.homeManagerConfiguration {
        # inherit pkgs;
        pkgs = pkgs-unstable;

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
      "notroot@spaghetti-llc" = home-manager-unstable.lib.homeManagerConfiguration {
        #inherit pkgs;
        pkgs = pkgs-unstable;
        modules = [
          inputs.nvf.homeManagerModules.default
          ./home-manager/spaghetti-llc_notroot/home.nix
          inputs.stylix-unstable.homeModules.stylix
          #          inputs.nixvim-unstable.homeModules.nixvim
          inputs.direnv-instant-unstable.homeModules.direnv-instant
        ];
      };
    };
    nixosConfigurations = {
      # Work nixos vm
      "work-nixos" = nixpkgs-unstable.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/hosts/work-nixos/configuration.nix
        ];
        # specialArgs = {
        #   pkgs-unstable = import inputs.nixpkgs-unstable {
        #     inherit system;
        #     config.allowUnfree = true;
        #   };
        # };
      };

      # Laptop 1
      "spaghetti-llc" = nixpkgs-unstable.lib.nixosSystem {
        inherit system;
        # specialArgs = { inherit inputs; };
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
    };
  };
}
