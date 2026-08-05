{ den, ... }:
{
  den.aspects.notroot = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.unfree [ "obsidian" ])
      den.aspects.kitty
      den.aspects.fish
      den.aspects.nvf
      den.aspects.dev
    ];

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        # TODO: Split out gnome things
        # Pinentry for gnome
        gcr
        gnomeExtensions.extension-list
        signal-desktop
        ripgrep
        uv
        proton-vpn-cli
        proton-vpn
      ];
      programs.obsidian = {
        enable = true;
        cli.enable = true;
      };
      programs.git = {
        enable = true;
        signing = {
          key = pkgs.lib.mkDefault "";
          signByDefault = true;
          format = "openpgp";
        };
        settings = {
          core.excludesfile = "~/.gitignore_global";
          init.defaultBranch = "main";
          push.autoSetupRemote = true;
        };
      };
      programs.gpg.enable = true;
      services.gpg-agent.enable = true;
      # TODO: Split out gnome things
      services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;

      dconf = {
        enable = true;
        settings = {
          "org/gnome/shell" = {
            favorite-apps = [
              "firefox.desktop"
              "org.gnome.Nautilus.desktop"
              "obsidian.desktop"
            ];
            # https://wiki.nixos.org/wiki/GNOME#Extensions
            disable-user-extensions = false;
            enabled-extensions = with pkgs.gnomeExtensions; [
              appindicator.extensionUuid
              extension-list.extensionUuid
            ];
          };
          "org/gnome/desktop/interface" = {
            clock-format = "12h";
          };
          "org/gtk/settings/file-chooser" = {
            clock-format = "12h";
          };
          "org/gnome/desktop/wm/keybindins" = {
            switch-windows = [ "<Alt>Tab" ];
            switch-windows-backwards = [ "<Shift><Alt>Tab" ];
          };
        };
      };
      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
      };
      home.file.".config/eza/theme.yml".text = pkgs.lib.readFile ../../assets/eza_onedark.yml;
    };

    provides.to-hosts = {
      # 1password needs to be configured at the host level to allow
      # it to do the magic socket / polkit things.
      nixos.programs = {
        _1password.enable = true;
        _1password-gui.enable = true;
        _1password-gui.polkitPolicyOwners = [ "notroot" ];
      };
    };

    provides.coffee-machine = {
      homeManager = { pkgs, ... }: {
        imports = [ ../_homeManager/coffee-machine_notroot/home.nix ];
      };
    };
    provides.work-nixos = {
      homeManager = { pkgs, ... }: {
        imports = [ ../_homeManager/work_notroot/home.nix];
      };
    };
    provides.spaghetti-llc = {
      homeManager = { pkgs, ... }: {
        imports = [ ../_homeManager/spaghetti-llc_notroot/home.nix ];
      };
    };

  };
}
