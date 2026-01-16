{ ... }:
{
  imports = [
    ./keymaps.nix
    ./lualine.nix
    ./languages/rust.nix
    ./languages/nix.nix
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
          lightbulb.enable = false;
          trouble.enable = true;
          lspconfig.enable = true;
          lspkind.enable = true;
          lspsaga.enable = false;
        };

        # Language support
        languages = {
          enableFormat = true;
          enableTreesitter = true;

          python.enable = true;
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
          friendly-snippets.enable = true;
          sourcePlugins.ripgrep.enable = true;
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
          borders.enable = true;
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
        notify.nvim-notify.setupOpts.background_colour = "#00000000";

        # Dashboard
        dashboard.dashboard-nvim.enable = true;

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
