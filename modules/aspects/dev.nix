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
      users.users.${user.userName}.extraGroups = [ "docker" ];
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
  den.aspects.dev.aws = {
    homeManager = { pkgs, ... }: {
      programs.awscli.enable = true;
      programs.fish.plugins = [
        {
          name = "fish-aws";
          inherit (pkgs.fishPlugins.aws) src;
        }
        {
          name = "omf-plugin-asp";
          src = pkgs.fetchFromGitHub {
            owner = "m-radzikowski";
            repo = "omf-plugin-asp";
            rev = "d3a154dc9511e93907160393cb96c90fb097e736";
            sha256 = "DBxJ0d3HWpBsrCKbyXjQiyWN9Cgs1Lat7EkKaodv0RY=";
          };
        }
      ];
    };
    den.aspects.dev.azure = {
      homeManager = { pkgs, ... }: {

        home.packages = [
          pkgs.azure-storage-azcopy
          pkgs.azure-cli
          pkgs.powershell
        ];

        services.remmina = {
          # I hate RDP most of all, but ya gotta have it
          enable = true;
          systemdService.enable = false;
        };
      };
    };
  };
}
