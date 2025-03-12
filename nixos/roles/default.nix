{ config, pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./pentest.nix
  ];
}