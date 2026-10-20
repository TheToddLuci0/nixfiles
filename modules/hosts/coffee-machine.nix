{ den, ... }: {

  den.aspects.coffee-machine = {
    nixos = { lib, pkgs, ... }: {
      imports = [ ../_nixos/hosts/coffee-machine/configuration.nix ];

      environment.systemPackages = [
        pkgs.tor-browser
        pkgs.cifs-utils
      ];

      power.ups = {
        enable = true;
        mode = "standalone";

        users."nut" = {
          upsmon = "primary";
          passwordFile = "/etc/nixos/ups-passwd.txt";
        };

        ups."UPS-1" = {
          description = "CyberPower CP1500PFCLCD PFC Sinewave UPS";
          driver = "usbhid-ups";
          port = "auto";
        };
        upsmon.monitor."UPS-1" = {
          user = "nut";
          passwordFile = "/etc/nixos/ups-passwd.txt";
        };
        upsmon.settings = {
          # This configuration file declares how upsmon is to handle
          # NOTIFY events.

          # POWERDOWNFLAG and SHUTDOWNCMD is provided by NixOS default
          # values

          NOTIFYCMD = ''${lib.getExe' pkgs.kitty "kitten"}" "notify''; # Quotes get mangled, this is gross but correct

          # values provided by ConfigExamples 3.0 book
          NOTIFYMSG = [
            [ "ONLINE" ''"UPS %s: On line power."'' ]
            [ "ONBATT" ''"UPS %s: On battery."'' ]
            [ "LOWBATT" ''"UPS %s: Battery is low."'' ]
            [ "REPLBATT" ''"UPS %s: Battery needs to be replaced."'' ]
            [ "FSD" ''"UPS %s: Forced shutdown in progress."'' ]
            [ "SHUTDOWN" ''"Auto logout and shutdown proceeding."'' ]
            [ "COMMOK" ''"UPS %s: Communications (re-)established."'' ]
            [ "COMMBAD" ''"UPS %s: Communications lost."'' ]
            [ "NOCOMM" ''"UPS %s: Not available."'' ]
            [ "NOPARENT" ''"upsmon parent dead, shutdown impossible."'' ]
          ];
          NOTIFYFLAG = [
            [ "ONLINE" "SYSLOG+WALL" ]
            [ "ONBATT" "SYSLOG+WALL+EXEC" ]
            [ "LOWBATT" "SYSLOG+WALL" ]
            [ "REPLBATT" "SYSLOG+WALL+EXEC" ]
            [ "FSD" "SYSLOG+WALL" ]
            [ "SHUTDOWN" "SYSLOG+WALL" ]
            [ "COMMOK" "SYSLOG+WALL" ]
            [ "COMMBAD" "SYSLOG+WALL+EXE" ]
            [ "NOCOMM" "SYSLOG+WALL" ]
            [ "NOPARENT" "SYSLOG+WALL" ]
          ];
          # every RBWARNTIME seconds, upsmon will generate a replace
          # battery NOTIFY event
          RBWARNTIME = 157700000; # Just under 5 years
          # every NOCOMMWARNTIME seconds, upsmon will generate a UPS
          # unreachable NOTIFY event
          NOCOMMWARNTIME = 300;
          # after sending SHUTDOWN NOTIFY event to warn users, upsmon
          # waits FINALDELAY seconds long before executing SHUTDOWNCMD
          # Some UPS's don't give much warning for low battery and will
          # require a value of 0 here for aq safe shutdown.
          FINALDELAY = 30;
        };
      };

      services.fwupd.enable = true;
      services.openssh.enable = true;

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      };
    };
  };
}
