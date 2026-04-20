{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.kitty.enable {
    programs.kitty = {
      enableGitIntegration = true;
      settings = {
        enable_audio_bell = false;
      };
      keybindings = {
        "f1" = "create_marker";
        "f2" = "remove_marker";
      };
    };
    home.file.".config/kitty/diff.conf".text = ''
      ignore_name flake.lock
    '';
    programs.zsh.shellAliases = {
      gd = "git difftool --dir-diff --no-symlinks";
    };
  };
}
