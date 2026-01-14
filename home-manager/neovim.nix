{ pkgs, ... }:
# https://nix-community.github.io/nixvim
{

#  # Enable font config so that the below nerd fonts are picked up
#  fonts.fontconfig.enable = lib.mkDefault true;
#  home.packages = with pkgs; [
#    (nerdfonts.override { fonts = ["FiraCode" "Hack"]; }) # web-devicons, installed here so fc can find them
#  ];
  programs.nixvim = {

    extraPackages = with pkgs; [
      ripgrep # Search, telescope
    ];

    enable = true;
    vimAlias = true;
    viAlias = true;
    vimdiffAlias = true;
    
    # Make it pretty
    colorschemes.onedark = {
      enable = true;
      settings = {
        style = "darker";
        transparent = true;
      };
    };
    
    # Make it work
    plugins = {
      treesitter = {
        enable = true;
	    settings = {
	      highlight.enable = true;
	      # This seems to make all the indents explode for some reason.
          # indent.enable = true;
	    };
      };
      telescope.enable = true;
      # Automatically enabled by telescope, but doesn't work without a system nerd font. 
      # TODO: Make dynamic
      web-devicons.enable = false;
      # Default friendly lsp configs
      lspconfig.enable = true;
    };

    # Syntax highlighting
    lsp = {
#      enable = true;
      servers = {
        lua_ls = {
          enable = true;
          config.telemetry.enable = false;
        };
        nixd.enable = true;
      };
    };

    # Make is useable
    globals = {
      mapleader = " ";
    };
    opts = {
      signcolumn = "yes";
      clipboard = "unnamedplus";
      number = true;
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      scrolloff = 8;

      updatetime = 50;
      termguicolors = true;
      hlsearch = false;
      incsearch = true;
      smartindent = true;

    };

  };
}
