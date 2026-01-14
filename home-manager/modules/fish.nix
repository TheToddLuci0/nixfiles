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
          src = pkgs.fishPlugins.grc.src;
        } # Colorized command output
        {
          name = "bang-bang";
          src = pkgs.fishPlugins.bang-bang.src;
        } # Let me !$ damnit
        {
          name = "colorized-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        } # Pretty man ;)
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
