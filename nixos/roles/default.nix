{ config, pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./pentest.nix
    ./gaming.nix
  ];
}