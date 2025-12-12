{
  config,
  pkgs,
  lib,
  ...
}:

{

  imports = [
    # ../neovim.nix
    ../hypr.nix
    ../modules
  ];

  nixpkgs.overlays = [
    (import ../../packages)
  ];

  # programs.zsh.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable welcome message
    '';
    plugins = [
      {name = "grc"; src = pkgs.fishPlugins.grc.src;} # Colorized command output
      {name = "bang-bang"; src = pkgs.fishPlugins.bang-bang.src; } # Let me !$ damnit
      {name = "colorized-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src; } # Pretty man ;)
    ];
  };
  programs.starship.enable = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "notroot";
  home.homeDirectory = "/home/notroot";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # Pinentry for gnome
    gcr

    # Pipx and magic shell completions
    python312Packages.argcomplete
    pipx
    obsidian

    # gnome shell
    gnomeExtensions.extension-list
    gnomeExtensions.system-monitor-next
    gmetronome

    zellij
    protonvpn-gui
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/notroot/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # GNOME settings
  dconf = {
    enable = true;
    settings = {
      # "org/gnome/desktop/interface" = {
      #   color-scheme = "prefer-dark";
      # };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "Flameshot";
        command = "flameshot gui";
        binding = "Print";
      };
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
          system-monitor-next.extensionUuid
          # Stylix
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };
      "org/gnome/desktop/interface" = {
        clock-format = "12h";
      };
      "org/gtk/settings/file-chooser" = {
        clock-format = "12h";
      };
    };
  };

 programs.git = {
   enable = true;
   signing.key = "";
   signing.signByDefault = true;
   settings = {
     core.excludesfile = "~/.gitignore_global";
     user.name = "E26D48B308C7C1C39CD3C3E686B35D9789EBE4A5";
     user.email = "thetoddluci0@pm.me";
     push = {
       autoSetupRemote = true;
     };
   };
 };

  home.file.".gitignore_global" = {
    text = "# Direnv stuff
            .direnv
            .envrc";
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      # extensions = [ pkgs.vscode-extensions.jnoortheen.nix-ide ];
    };
  };

  programs.gpg.enable = true;
  programs.gpg.publicKeys = [
    {
      source = ../assets/gpg/work_pubkey.gpg;
      trust = "ultimate";
    }
  ];

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.direnv-instant.enable = true;

  programs.kitty.enable = true;

}
