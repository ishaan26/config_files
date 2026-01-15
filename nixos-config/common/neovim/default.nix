{ pkgs, ... }:

{
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        # Aliases
        viAlias = false;
        vimAlias = true;

        # Theme - disabled, Stylix handles this via base16
        # theme = {
        #   enable = true;
        #   name = "catppuccin";
        #   style = "mocha";
        # };

        # Statusline
        statusline.lualine = {
          enable = true;
          # theme handled by Stylix
        };

        # File tree
        filetree.neo-tree = {
          enable = true;
        };

        # Treesitter for better syntax highlighting
        treesitter = {
          enable = true;
          context.enable = true;
          highlight.enable = true;
          indent.enable = true;
        };

        # LSP configuration
        lsp = {
          enable = true;
          formatOnSave = true;
          # lspSignature.enable = true;
          lightbulb.enable = true;
          trouble.enable = true;
        };

        # Language support
        languages = {
          enableFormat = true;
          enableTreesitter = true;

          # Languages
          nix.enable = true;
          python.enable = true;
          rust.enable = true;
          ts.enable = true;
          html.enable = true;
          css.enable = true;
          markdown.enable = true;
          bash.enable = true;
          lua.enable = true;
        };

        # Autocompletion
        autocomplete.blink-cmp = {
          enable = true;
        };

        # Fuzzy finder
        telescope = {
          enable = true;
        };

        # Git integration
        git = {
          enable = true;
          gitsigns.enable = true;
        };

        # UI enhancements
        ui = {
          noice.enable = true;
          illuminate.enable = true;
        };

        # Utility features
        utility = {
          surround.enable = true;
          motion.leap.enable = true;
        };

        # Comments
        comments.comment-nvim.enable = true;

        # Autopairs
        autopairs.nvim-autopairs.enable = true;

        # Which-key for keybinding hints
        binds.whichKey.enable = true;

        # Better notifications
        notify.nvim-notify.enable = true;

        # Options
        options = {
          number = true;
          relativenumber = true;
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          smartindent = true;
          wrap = false;
          cursorline = true;
          termguicolors = true;
          signcolumn = "yes";
          scrolloff = 8;
          updatetime = 50;
        };

        # Keymaps
        keymaps = [
          # File tree toggle
          {
            key = "<leader>e";
            mode = "n";
            action = "<cmd>Neotree toggle<cr>";
            desc = "Toggle file tree";
          }
          # Telescope
          {
            key = "<leader>ff";
            mode = "n";
            action = "<cmd>Telescope find_files<cr>";
            desc = "Find files";
          }
          {
            key = "<leader>fg";
            mode = "n";
            action = "<cmd>Telescope live_grep<cr>";
            desc = "Live grep";
          }
          {
            key = "<leader>fb";
            mode = "n";
            action = "<cmd>Telescope buffers<cr>";
            desc = "Find buffers";
          }
          # Window navigation
          {
            key = "<C-h>";
            mode = "n";
            action = "<C-w>h";
            desc = "Move to left window";
          }
          {
            key = "<C-j>";
            mode = "n";
            action = "<C-w>j";
            desc = "Move to bottom window";
          }
          {
            key = "<C-k>";
            mode = "n";
            action = "<C-w>k";
            desc = "Move to top window";
          }
          {
            key = "<C-l>";
            mode = "n";
            action = "<C-w>l";
            desc = "Move to right window";
          }
        ];
      };
    };
  };
}
