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
  };
}
