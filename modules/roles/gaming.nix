{den, ...}: {
  den.aspects.gaming = {
    user,
    host,
  }: {
    includes = [
      den.aspects.steam
    ];
    nixos = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        discord
        crosspipe # Lets you view pipewire graph and connect IOs
        rtaudio
      ];
      programs.gamemode.enable = true;
      users.users.${user.userName}.extraGroups = ["gamemode"];
    };
  };
}
