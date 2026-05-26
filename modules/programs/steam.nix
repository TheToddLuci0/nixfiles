{den, ...}: {
  den.aspects.steam = {
    nixos = _: {
      # TODO: Make the firewall ports dynamic so they're not on all the time
      # Probably needs to be a specialization?
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
  };
}
