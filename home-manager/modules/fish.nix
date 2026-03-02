{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.fish.enable {
    home.shell.enableFishIntegration = true;
    home.packages = with pkgs; [
      python3
      grc
      nix-your-shell
    ];
    programs.fish = {
      plugins = [
        {
          name = "grc";
          inherit (pkgs.fishPlugins.grc) src;
        } # Colorized command output
        {
          name = "bang-bang";
          inherit (pkgs.fishPlugins.bang-bang) src;
        } # Let me !$ damnit
        {
          name = "colorized-man-pages";
          inherit (pkgs.fishPlugins.colored-man-pages) src;
        } # Pretty man ;)
        {
          name = "fish-you-should-use";
          inherit (pkgs.fishPlugins.fish-you-should-use) src;
        }
        {
          name = "omf-plugin-asp";
          src = pkgs.fetchFromGitHub {
            owner = "m-radzikowski";
            repo = "omf-plugin-asp";
            rev = "d3a154dc9511e93907160393cb96c90fb097e736";
            sha256 = "DBxJ0d3HWpBsrCKbyXjQiyWN9Cgs1Lat7EkKaodv0RY=";
          };
        }
      ];
      interactiveShellInit = ''
        set fish_greeting # Disable welcome message
        if command -q nix-your-shell
          nix-your-shell fish | source
        end
      '';
      shellAbbrs = {
        ll = "ls -laFh";
        la = "ls -A";
        grep = "grep --color=auto";
        diff = "diff --color=auto";
        open = "xdg-open";
        "!!" = {
          position = "anywhere";
          function = "last_history_item";
        };
      };
      functions = {
        last_history_item = "echo $history[1]";
      };
    };
    programs.starship = {
      enableFishIntegration = true;
      enableTransience = true;
    };
  };
}
