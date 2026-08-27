{den, ...}: {

  den.aspects.coffee-machine = {
    nixos = {pkgs, ...}: {
      imports = [../_nixos/hosts/coffee-machine/configuration.nix];

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
  };
}
