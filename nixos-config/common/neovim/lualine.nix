{
  programs.nvf.settings.vim.statusline.lualine = {
    enable = true;
    # Theme is handled by Stylix via base16

    # Component separators
    componentSeparator = {
      left = "";
      right = "";
    };

    sectionSeparator = {
      left = "";
      right = "";
    };

    # Active sections
    activeSection = {
      a = [
        ''
          {
            "mode",
            fmt = function(str) return str:sub(1,1) end
          }
        ''
      ];
      b = [
        ''"branch"''
        ''"diff"''
      ];
      c = [
        ''
          {
            "filename",
            path = 1,
            symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" }
          }
        ''
      ];
      x = [
        ''"diagnostics"''
      ];
      y = [
        ''"filetype"''
      ];
      z = [
        ''"location"''
        ''"progress"''
      ];
    };

    # Inactive sections
    inactiveSection = {
      a = [];
      b = [];
      c = [
        ''
          {
            "filename",
            path = 1
          }
        ''
      ];
      x = [];
      y = [];
      z = [];
    };
  };
}
