{
  config,
  lib,
  ...
}:

{
  config = lib.mkIf config.programs.kitty.enable {
    programs.kitty = {
      settings = {
        enable_audio_bell = false;
      };
    };
  };
}
