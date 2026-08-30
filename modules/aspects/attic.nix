{ den, ... }: {

  den.aspects.attic.client = {
    nixos = {
      nix.settings.substituters = ["https://ttl0cache.dev/default"];
      nix.settings.trusted-public-keys = ["default:4/STs2YRgVgw7ReD1eeQQBwZwIZUjOjIJirGahS7pEg="];
    };
    homeManager = { pkgs, ... }: {
      programs.attic-client = {
        enable = true;
        watchStore = ["ttl0cache:default"];
        settings = {
          default-cache = "ttl0cache";
          servers.ttl0cache = {
            endpoint = "https://ttl0cache.dev";
            #TODO: Setup opnix or something.
            token-file = "/run/secrets/attic-token";
          };
        };
      };
    };
  };
}
