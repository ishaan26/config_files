{
  programs.nvf.settings.vim.languages.rust = {
    enable = true;

    lsp = {
      enable = true;
      opts = ''
        ['rust-analyzer'] = {
          cargo = {allFeature = true},
          checkOnSave = true,
          procMacro = {
            enable = true,
          },
        },
      '';
    };

    treesitter.enable = true;

    dap.enable = true;

    extensions = {
      crates-nvim = {
        enable = true;
        setupOpts.completion.crates.enabled = true;
        setupOpts.lsp.actions = true;
      };
    };
  };
}
