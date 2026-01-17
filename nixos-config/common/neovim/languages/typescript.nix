{
  programs.nvf.settings.vim.languages.ts = {
    enable = true;
    lsp.enable = true;
    extraDiagnostics.enable = true;

    extensions = {
      ts-error-translator.enable = true;
    };

    format = {
      enable = true;
      type = [ "biome" ];
    };
  };
}
