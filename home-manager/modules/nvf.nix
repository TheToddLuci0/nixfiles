{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # Enable the aliases so I don't have to remember wtf an nvim is
        viAlias = true;
        vimAlias = true;

        # Keymappings
        keymaps = [
          {
            key = "<leader>mt";
            mode = "n";
            action = ":Neotree toggle<CR>";
            desc = "Toggle Neotree";
          }
        ];

        extraPackages = with pkgs; [
          ripgrep
          fzf
          gcc
        ];
        # Handled by stylix
        #        theme = {
        #          enable = true;
        #          name = "onedark";
        #          style = "dark";
        #        };

        lsp.enable = true;
        treesitter = {
          enable = true;
          indent.disable = [ "nix" ];
        };

        comments.comment-nvim.enable = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;

          bash.enable = true;
          hcl.enable = true;
          markdown.enable = true;
          python.enable = true;
          nix.enable = true;
          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
          };
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        # autocomplete.blink-cmp.enable = true;

        git = {
          enable = true;
          neogit.enable = true;
        };

        # Friendly little helper window for remembering kebinds
        binds.whichKey = {
          enable = true;
        };
        mini.icons.enable = true; # Used by a couple things, just icons

        minimap.codewindow.enable = true;
        minimap.minimap-vim.enable = false;

        #Scrollbar
        visuals.nvim-scrollbar.enable = true;

        # Alert window for nvim
        visuals.fidget-nvim.enable = true;
        notify.nvim-notify.enable = true;

        # A VSC style file browser on the left
        filetree.neo-tree.enable = true;
      };
    };
  };
}
