{ den, ... }: {

  den.default = {
    includes = [den.aspects.stylix];
    nixos = { pkgs, lib, ... }: {
      programs.nh = {
        enable = true;
        flake = lib.mkDefault "/home/notroot/git/nixfiles";
      };
      environment.systemPackages = with pkgs; [
        git
      ];
    };
    homeManager = {
      programs.git.enable = true;
      programs.starship.enable = true;
    };
  };

}
