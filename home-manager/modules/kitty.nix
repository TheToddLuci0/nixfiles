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
    };
  home.file.".config/kitty/diff.conf".text = ''
    ignore_name flake.lock
  '';
  };
}
