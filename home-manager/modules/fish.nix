{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = lib.mkIf config.programs.fish.enable {
    home.shell.enableFishIntegration = true;
    home.packages = with pkgs; [
      python3
      grc
      nix-your-shell
    ];
    programs.fish = {
        interactiveShellInit = ''
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
