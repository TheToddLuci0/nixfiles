{pkgs, ...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # Enable the aliases so I don't have to remember wtf an nvim is
        viAlias = true;
        vimAlias = true;

        options.shiftwidth = 2;
        # This doesn't prevent folding, it just doesn't automatically fold everything on load
        # https://stackoverflow.com/a/79405264
        options.foldenable = false;
        # Set the default to a high level so we don't fold everything if we try to fold once
        options.foldlevel = 99;

        # Keymappings
        keymaps = [
          {
            key = "<leader>mt";
            mode = "n";
            action = ":Neotree toggle<CR>";
            desc = "Toggle Neotree";
          }
          {
            # For some reason, this isn't getting loaded into whichkey by default. It exists once you run `:Cheatsheet` once.
            # TODO: Figure out how to load it before whichkey
            key = "<leader>?";
            mode = "n";
            action = ":Cheatsheet<CR>";
            desc = "Search for keybinds in Telescope";
          }
          {
            key = "<ESC>"; # :tnoremap <Esc> <C-\><C-n>
            mode = "t";
            action = "<C-\\><C-n>";
            desc = "Exit terminal mode";

          }
        ];

        syntaxHighlighting = true;

        extraPackages = with pkgs; [
          ripgrep
          fzf
          gcc
        ];

        lsp.enable = true;
        lsp.servers.nil = {
          nix.autoArchive = true;
        };
        treesitter = {
          enable = true;
          fold = true;
          # indent.enable = false;
          # indent.disable = [ "nix" ]; # Possibly needs replaces with vim.treesitter.indent.enable = false
        };

        comments.comment-nvim.enable = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableDAP = true;

          bash.enable = true;
          docker.enable = true;
          fish.enable = true;
          hcl.enable = true;
          markdown = {
            enable = true;
            extensions.markview-nvim.enable = true;
          };
          python.enable = true;
          nix.enable = true;
          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
          };
          go.enable = true;
          yaml.enable = true;
          toml.enable = true;
          tex.enable = true;
          sql.enable = true;
          html.enable = true;
          css.enable = true;
          json.enable = true;
          typescript.enable = true;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        # autocomplete.blink-cmp.enable = true;

        git = {
          enable = true;
          neogit.enable = true;
        };

        # Friendly little helper window for remembering kebinds
        binds.whichKey.enable = true;
        # telescope search. Use `<leader>?` to trigger
        binds.cheatsheet.enable = true;
        mini.icons.enable = true; # Used by a couple things, just icons

        # https://github.com/NotAShelf/nvf/issues/1312#issuecomment-3717096367
        # minimap.codewindow.enable = true;
        minimap.minimap-vim.enable = false;

        visuals = {
          #Scrollbar
          nvim-scrollbar.enable = true;
          # progress window for nvim, lower right
          fidget-nvim.enable = true;
          # Highlight things we curse over
          nvim-cursorline.enable = true;
        };

        # Better terminal
        terminal.toggleterm.enable = true;

        # Pretty notifications, top left. More important things go here
        notify.nvim-notify.enable = true;

        # A VSC style file browser on the left
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            close_if_last_window = true; # Don't become a zombie IDE if there's just the browser open
          };
        };
      };
    };
  };
}
