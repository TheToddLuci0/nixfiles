{...}:{

  den.aspects.proton = {
    homeManager = {pkgs, ...}: {
      # services.proton-pass-agent.enable = true;
      home.packages = [
        pkgs.proton-pass
        pkgs.proton-vpn
        pkgs.proton-pass-cli
        pkgs.proton-vpn-cli
      ];
    };
  };
}
