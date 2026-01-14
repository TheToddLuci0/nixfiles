self: super: with self; 

{
  keeperpasswordmanager = super.callPackage ./keeper.nix {};
  bbot = super.callPackage ./bbot.nix {};
  keeper-secrets-manager-core = super.python3.pkgs.callPackage ./keeper-secrets-manager-core.nix {};
  keepercommander = super.python3.pkgs.callPackage ./keepercommander.nix {};
  keeper = super.callPackage ./keeper-cli.nix {};
}
