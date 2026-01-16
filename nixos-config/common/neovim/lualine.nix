{ config, ... }:
let
  inherit (config.lib.stylix) colors;
in
{
  programs.nvf.settings.vim.statusline.lualine = {
    enable = true;

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
      a = [ ];
      b = [ ];
      c = [
        ''
          {
            "filename",
            path = 1
          }
        ''
      ];
      x = [ ];
      y = [ ];
      z = [ ];
    };
  };

  # Define custom theme and override
  programs.nvf.settings.vim.luaConfigRC.lualine_theme_override = ''
    local custom_base00 = {
      normal = {
        a = { fg = "#${colors.base0B}", bg = "#${colors.base00}", gui = "bold" },
        b = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        c = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
      },
      insert = {
        a = { fg = "#${colors.base0D}", bg = "#${colors.base00}", gui = "bold" },
        b = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        c = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
      },
      visual = {
        a = { fg = "#${colors.base0E}", bg = "#${colors.base00}", gui = "bold" },
        b = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        c = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
      },
      replace = {
        a = { fg = "#${colors.base08}", bg = "#${colors.base00}", gui = "bold" },
        b = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        c = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
      },
      command = {
        a = { fg = "#${colors.base0A}", bg = "#${colors.base00}", gui = "bold" },
        b = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        c = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
      },
      inactive = {
        a = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        b = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
        c = { fg = "#${colors.base05}", bg = "#${colors.base00}" },
      },
    }

    -- Override lualine config with our custom theme
    -- We wait for lualine to be loaded, get its current config, swap the theme, and re-setup
    vim.schedule(function()
      local lualine = require('lualine')
      local config = lualine.get_config()
      config.options.theme = custom_base00
      lualine.setup(config)
    end)
  '';
}
