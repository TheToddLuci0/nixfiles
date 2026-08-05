{
  inputs,
  den,
  lib,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.hosts.x86_64-linux.toaster-oven.users.notroot = { };
  den.homes.x86_64-linux."notroot@toaster-oven" = { };

  den.hosts.x86_64-linux.coffee-machine.notroot = { };
  den.homes.x86_64-linux."notroot@coffee-machine" = { };

  den.hosts.x86_64-linux."spaghetti-llc".notroot = { };
  den.homes.x86_64-linux."notroot@spaghetti-llc" = { };

  den.hosts.x86_64-linux.work-nixos.notroot = { };
  den.homes.x86_64-linux."notroot@work-nixos" = { };

  den.default.homeManager.home.stateVersion = "24.11";
  den.default.nixos.system.stateVersion = lib.mkDefault "25.05";
}
