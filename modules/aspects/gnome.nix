{den, ...}: {
  den.aspects.gnome = {

    nixos = {pkgs, ...}: {
      # Disable the email client
      programs.geary.enable = false;
      # Disable unneeded packages
      # Took a list of all installed, commented the ones to keep
      environment.gnome.excludePackages = with pkgs; [
        # gnome-backgrounds-47.0
        # gnome-bluetooth-47.1
        # gnome-bluetooth-47.1-man
        # gnome-browser-connector-42.1
        # gnome-calculator-47.1
        gnome-calendar
        # gnome-characters-47.0
        # gnome-clocks-47.0
        # gnome-color-manager-3.32.0
        gnome-connections
        gnome-console
        gnome-contacts
        # gnome-control-center-47.2
        # gnome-disk-utility-46.1
        # gnome-font-viewer-47.0
        # gnome-initial-setup-47.2
        # gnome-keyring-46.2
        gnome-logs
        gnome-maps
        # gnome-menus-3.36.0
        gnome-music
        # gnome-online-accounts-3.52.3.1
        # gnome-online-accounts-3.52.3.1-man
        # gnome-remote-desktop-47.2
        # gnome-session-47.0.1
        # gnome-settings-daemon-47.2
        # gnome-shell-47.2
        # gnome-shell-extensions-47.2
        # gnome-system-monitor-47.0
        gnome-text-editor
        gnome-tour
        # gnome-user-docs-47.2
        # gnome-user-share-47.2
        # gnome-weather-47.0
	epiphany
      ];

      # Disable unneeded services
      services.gnome = {
        gnome-online-accounts.enable = false;
      };

      # Enable fancy shell extensions
      environment.systemPackages = with pkgs.gnomeExtensions; [
        appindicator
        extension-list
        system-monitor-next
      ];

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Autogen stuff
      services.udev.packages = [pkgs.gnome-settings-daemon];

      # from autogen configuration.nix
  
      # Enable the X11 windowing system
      services.xserver.enable = true;
  
      # Enable the GNOME Desktop Environment.
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
  


    };
    
  };
}
