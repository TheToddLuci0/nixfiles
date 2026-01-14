# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../window-managers/default.nix
    ../../roles
  ];

  # Enable custom roles
  ttl0.roles = {
    pentest.enable = true;
  };

  # Tell nixos that we're on a vmware vm
  virtualisation.vmware.guest.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "work-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  #  ttl0.windowManagers.hyprland.enable = true;
  ttl0.windowManagers.gnome.enable = true;
  #  # Enable the X11 windowing system.
  #  services.xserver.enable = true;
  #
  #  # Enable the GNOME Desktop Environment.
  #  services.xserver.displayManager.gdm.enable = true;
  #  services.xserver.desktopManager.gnome.enable = true;
  #
  #  # Configure keymap in X11
  #  services.xserver.xkb = {
  #    layout = "us";
  #    variant = "";
  #  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.notroot = {
    isNormalUser = true;
    description = "Test Haxor";
    extraGroups = ["networkmanager" "wheel" "kvm" "docker"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    gnumake
    zsh
    kitty
    tmux
    #    gnomeExtensions.appindicator
    neovim
    nixd
    nixfmt-rfc-style
    python3
    gh
    usbutils
    protonvpn-gui
  ];

  #  services.udev.packages = with pkgs; [
  #    gnome-settings-daemon
  #  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Automate garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  # Automatically update nixpkgs
  system.autoUpgrade.enable = true;

  # ZSH over BASH
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh bash];

  #  # Use vim as default
  #  programs.vim.defaultEditor = true;
  #  programs.vim.enable = true;

  # Use nvim as default
  #  programs.neovim.enable = true;
  #  programs.neovim.defaultEditor = true;
  #  programs.neovim.configure = {
  #
  #  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Enable nix-command and flakes
  # nix = {
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.openvpn3 = {
    enable = true;
    # This should set it to nothing. Without this explicit cast, the vpn won't work
    netcfg.settings = {
      log_level = 4;
    };
  };
  # services.openvpn.servers = {

  #   converge = {
  #     config = '' config /root/openvpn/converge.ovpn '';
  #     updateResolvConf = true;
  #   };
  # }
  # ;

  # Password Managers
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs._1password-gui.polkitPolicyOwners = ["notroot"];

  # needed for ZSH autocomplete to work propperly
  environment.pathsToLink = ["/share/zsh"];

  # Yubikey
  security.pam.u2f.settings.cue = true; # Show a reminder
  security.pam.u2f.enable = true;
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  # First one is the AWS yubikey clone
  # Second one is the OnlyKey
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0417",\
     ENV{ID_VENDOR_ID}=="1949",\
     ENV{ID_VENDOR}=="Amazon",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="60fc",\
     ENV{ID_VENDOR_ID}=="1d50",\
     ENV{ID_VENDOR}=="CRYPTOTRUST",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';

  #DNS
  networking = {
    nameservers = ["127.0.0.1" "::1"];
    # If using dhcpcd:
    # dhcpcd.extraConfig = "nohook resolv.conf";
  };
  # # If using NetworkManager:
  networking.networkmanager.dns = "none";
  # DNSSEC / DNSCrypt / DoH
  services.dnscrypt-proxy = {
    enable = true;
    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      # ipv6_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
      # query_log.file = "/var/log/dnscrypt-proxy/query.log";
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };

      # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
      # server_names = [ ... ];
    };
  };
  programs.nix-ld = {
    enable = true;
  };
}
