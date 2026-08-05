{ den, ... }: {

  den.aspects.kitty = {

    homeManager = { pkgs, ... }: {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        settings = {
          enable_audio_bell = false;
        };
        keybindings = {
          "f1" = "create_marker";
          "f2" = "remove_marker";
        };
        diffConfig = {
          settings = {
            # Don't display flake.lock in diffs, it's big.
            ignore_name = "flake.lock";
          };
        };
      };
    };
  };
}
