{ pkgs, ... }: {
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings = {
      vim = {
        # Enable the aliases so I don't have to remember wtf an nvim is
        viAlias = true;
        vimAlias = true;

        hideSearchHighlight = true;

        options = {
          shiftwidth = 2;
          # This doesn't prevent folding, it just doesn't automatically fold everything on load
          # https://stackoverflow.com/a/79405264
          foldenable = false;
          # Set the default to a high level so we don't fold everything if we try to fold once
          foldlevel = 99;
        };

        spellcheck = {
          enable = true;
          # The download keeps 404-ing
          # programmingWordlist.enable = true;
          ignoredFiletypes = [ "neo-tree" "alpha"];
        };

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

        lsp = {
          enable = true;
          lightbulb.enable = true; # VSC style light bulb if there's an action available
          presets.harper.enable = true; # Grammar checker. Remove if it makes things too slow.
        };
        lsp.servers.nil = {
          nix.autoArchive = true;
        };
        treesitter = {
          enable = true;
          fold = true;
        };

        comments.comment-nvim.enable = true;

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableDAP = true;
          enableExtraDiagnostics = true;

          bash.enable = true;
          docker.enable = true;
          fish.enable = true;
          hcl.enable = true;
          markdown = {
            enable = true;
            extensions.markview-nvim.enable = true;
          };
          python = {
            enable = true;
            format.type = ["ruff"];
            lsp.servers = ["ruff"];
          };
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
          terraform.enable = true;
          zsh.enable = true;

        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.blink-cmp.enable = true;

        git = {
          enable = true;
          neogit.enable = true;
        };

        # Friendly little helper window for remembering keybinds
        binds.whichKey.enable = true;
        # Telescope search. Use `<leader>?` to trigger
        binds.cheatsheet.enable = true;
        mini.icons.enable = true; # Used by a couple of things, just icons

        # https://github.com/NotAShelf/nvf/issues/1312#issuecomment-3717096367
        # minimap.codewindow.enable = true;
        minimap.minimap-vim.enable = true;

        visuals = {
          #Scrollbar
          nvim-scrollbar.enable = true;
          # progress window for nvim, lower right
          # fidget-nvim.enable = true;
          # Highlight things we curse over
          nvim-cursorline.enable = true;
          # Icons, used by other things
          nvim-web-devicons.enable = true;

          # Indent gutters, aka "How far away is this closure?"
          blink-indent.enable = true;
          # See what changed when running outside of insert mode.
          highlight-undo.enable = true;

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

        # Debugging
        debugger.nvim-dap = {
          enable = true;
          ui.enable = true;
        };
        
        # Landing page
        dashboard.alpha.enable = true;

        utility = {
          # "What's at the other end of this closure"
          nvim-biscuits = {
            enable = true;
            setupOpts = {
              cursor_line_only = true;
              default_config = {
                min_distance = 10;
              };
            };
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
        };
      };
    };
  };
}
