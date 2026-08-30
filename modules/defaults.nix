{ den, ... }: {

  den.default = {
    # Things that belong on all hosts I manage, no matter what.
    # This should be a pretty slim list, and mainly be things that are needed to bootstrap
    # a new system or recover one that gets particularly messed up.
    includes = [ den.aspects.stylix ];
    
    nixos = { pkgs, lib, ... }: {
      nix.settings.trusted-users = ["@wheel"];
      programs.nh = {
        enable = true;
        flake = lib.mkDefault "/home/notroot/git/nixfiles";
      };
      environment.systemPackages = with pkgs; [
        git
        ripgrep
      ];
      programs.bat = {
        enable = true;
        settings = {
          theme = "TwoDark";
        };
      };
    };

    homeManager = {
      programs.git.enable = true;
      programs.starship.enable = true;
    };
  };

}
