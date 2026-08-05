{ inputs, den, ... }:
{
  flake-file.inputs.direnv-instant = {
    url = "github:Mic92/direnv-instant";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.direnv = {
    homeManager = {
      imports = [inputs.direnv-instant.homeModules.direnv-instant];
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      programs.direnv-instant.enable = true;
      programs.git.ignores = [
        # Direnv stuff
        ".direnv"
        ".envrc"
      ];
    };
  };
}
