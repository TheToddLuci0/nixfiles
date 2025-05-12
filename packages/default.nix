self: super:

{
  keeperpasswordmanager = super.callPackage ./keeper.nix {};
  bbot = super.callPackage ./bbot.nix {};
}