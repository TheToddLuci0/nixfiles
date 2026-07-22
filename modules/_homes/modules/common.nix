{pkgs, ...}: {
  # Configuration for all hosts.
  # home.packages = with pkgs; [
  #   ripgrep
  #   uv
  # ];
  programs.uv.enable = true;
  programs.ripgrep.enable = true;
  programs.fd.enable = true;
}
