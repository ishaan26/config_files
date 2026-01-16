{
  programs.nvf.settings.vim.languages.nix = {
    enable = true;
    extraDiagnostics.enable = true;

    lsp.enable = true;

    format = {
      enable = true;
      type = ["nixfmt"];
    };

    treesitter.enable = true;
  };
}
