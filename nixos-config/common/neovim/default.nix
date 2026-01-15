{...}: {
  imports = [
    ./keymaps.nix
    ./lualine.nix
    ./languages/rust.nix
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        # Aliases
        viAlias = false;
        vimAlias = true;

        # Transparent background
        luaConfigRC.transparency = ''
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
          vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        '';

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
      };
    };
  };
}
