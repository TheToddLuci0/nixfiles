{pkgs, ...}: {
  # Configuration for all hosts.
  home.packages = with pkgs; [
    ripgrep
    uv
  ];
}
