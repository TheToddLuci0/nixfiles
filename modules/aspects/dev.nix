{ den, ... }:
{
  den.aspects.dev = {
    includes = [
      den.aspects.direnv
    ];
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.git
        pkgs.gnumake
        pkgs.rustup
        pkgs.gcc
        pkgs.bacon
      ];
    };
  };
  den.aspects.dev.docker = {
    nixos = { user, ... }: {
      users.users.${user.userName}.extraGroups = ["docker"];
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
      virtualisation.docker.daemon.settings = {
        pruning = {
          enabled = true;
          interval = "24h";
        };
      };
    };
  };
}
