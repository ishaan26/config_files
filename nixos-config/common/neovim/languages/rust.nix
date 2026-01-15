{
  programs.nvf.settings.vim.languages.rust = {
    enable = true;
    lsp.enable = true;
    lsp.opts = ''
      ['rust-analyzer'] = {
        cargo = {allFeature = true},
        checkOnSave = true,
        procMacro = {
          enable = true,
        },
      },
    '';
    dap.enable = true;
    extensions = {
      crates-nvim.enable = true;
      crates-nvim.setupOpts.completion.crates.enabled = true;
      crates-nvim.setupOpts.lsp.actions = true;
    };
  };
}
