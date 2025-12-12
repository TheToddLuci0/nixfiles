{ lib, config, pkgs, ... }:

# Things that I want system wide on all hosts
{
    environment.systemPackages = with pkgs; [
        git
        bat
    ];

    programs.nh = {
        # Magical "Make things easier / prettier" nix helper
        enable = true;
    };

    programs.bat = {
        enable = true;
        settings = {
            theme = "TwoDark";
        };
    };
}