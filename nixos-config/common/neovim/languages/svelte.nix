{
  programs.nvf.settings.vim.languages.svelte = {
    enable = true;
    extraDiagnostics.enable = true;

    lsp.enable = true;

    format = {
      enable = true;
      type = [ "biome" ];
    };

  };
}
