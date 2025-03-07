{
  config,
  pkgs,
  lib,
  ...
}:

{

  imports = [
    ../neovim.nix
    ../hypr.nix
  ];

  nixpkgs.overlays = [
    (import ../../packages)
  ]
  ;

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

    keeperpasswordmanager 

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
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "tokyonight-dark";
      package = pkgs.tokyonight-gtk-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

  };
  home.sessionVariables.GTK_THEME = "tokyonight-dark";

  programs.git = {
    enable = true;
    userName = "TheToddLuci0";
    userEmail = "26094248+TheToddLuci0@users.noreply.github.com";
    signing.key = "87FAEE526515AA13B02589579C29A212F5B2F101";
    signing.signByDefault = true;
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.vscode = {
    enable = true;
    extensions = [ pkgs.vscode-extensions.jnoortheen.nix-ide ];
  };

  programs.gpg.enable = true;
  programs.gpg.settings = {
    default-key = "87FAEE526515AA13B02589579C29A212F5B2F101";
  };

  programs.gpg.publicKeys = [
    {
      source = ../assets/gpg/work_pubkey.gpg;
      trust = "ultimate";
    }
  ];

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    includes = [
      "~/.ssh/1Password/config"
    ];
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
    '';
    matchBlocks =
      lib.trivial.mergeAttrs
        (lib.trivial.mergeAttrs
          # This magic generates the SSH config entries for each of the MANTIS devices. It's a bit ugly, but since I'll never have to edit my hosts file directly, I don't care.
          (builtins.listToAttrs (
            builtins.genList (x: {
              name = "mantis-${toString x}";
              value = {
                user = "converge";
                hostname = "172.29.249.1${toString x}";
              };
            }) 50
          ))
          (
            builtins.listToAttrs (
              builtins.genList (x: {
                name = "mantis-kali-${toString x}";
                value = {
                  user = "converge";
                  port = 2200;
                  hostname = "172.29.249.1${toString x}";
                };
              }) 50
            )
          )
        )
        # non-generated SSH configs go here
        {
          "aws-vpn" = {
            hostname = "172.29.245.16";
            user = "ubuntu";
            # identityFile = "$HOME/.ssh/etg_pt_01.pem";
          };
          "mantis-kali" = {
            hostname = "172.29.249.128";
            port = 2200;
            # identityFile = "$HOME/.ssh/id_rsa";
          };
          "mccracken" = {
            hostname = "172.29.249.98";
            user = "converge";
            # identityFile = "$HOME/.ssh/id_rsa";
          };
          "controller" = {
            user = "lwoolery";
            hostname = "172.29.246.221";
          };
          "nessis" = {
            user = "ec2-user";
            hostname = "172.29.246.158";
          };
          "aws-cracker" = {
            user = "ubuntu";
            hostname = "172.29.246.222";
          };
          "recon-heavy" = {
            user = "kali";
            hostname = "172.29.246.58";
          };
        };
  };

  # VPN Magic
  home.shellAliases = {
    vpn-up = "openvpn3 session-start --config converge-vpn";
    vpn-dc = "openvpn3 sessions-list | grep Path | awk '{print \$NF}' | xargs openvpn3 session-manage --disconnect --path ";
  };

  programs.awscli = {
    enable = true;
    # credentials = {};
    settings = {
      "sso-session cbi-sso" = {
        sso_region = "us-east-1";
        sso_start_url = "https://convergets.awsapps.com/start";
        sso_registration_scopes = "sso:account:access";
      };
      # "profile redteam-admin" = {
      #   sso_session = "cbi-sso";
      #   sso_account_id = "641971825827";
      #   sso_role_name = "AWSAdministratorAccess";
      #   region = "us-east-1";
      # };
      "profile controller" = {
        role_arn = "arn:aws:iam::641971825827:role/controller_instance_role";
        source_profile = "redteam-infra";
        region = "us-west-2";
      };
      "profile redteam-infra" = {
        sso_session = "cbi-sso";
        sso_account_id = "641971825827";
        sso_role_name = "AWSAdministratorAccess";
        region = "us-east-1";
      };
    };
  };

}
