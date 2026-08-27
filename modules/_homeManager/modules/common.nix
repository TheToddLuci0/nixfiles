{pkgs, ...}: {
  # Configuration for all hosts.
  home.packages = with pkgs; [
    ripgrep
    uv
  ];
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  home.file.".config/eza/theme.yml".text = pkgs.lib.readFile ../assets/eza/one_dark.yml;
}
