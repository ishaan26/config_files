{
  programs.nvf.settings.vim = {
    autocomplete.blink-cmp = {
      enable = true;

      sourcePlugins = {
        ripgrep.enable = true;
      };

      setupOpts = {
        # Appearance
        appearance = {
          nerd_font_variant = "mono";
          use_nvim_cmp_as_default = false;
        };

        # Completion configuration
        completion = {
          # Keyword matching
          keyword = {
            range = "full"; # Match text before AND after cursor
          };

          # Menu appearance
          menu = {
            enabled = true;
            border = "rounded";
          };

          # Documentation window
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
            window = {
              border = "rounded";
              scrollbar = true;
            };
          };

          # Ghost text
          ghost_text = {
            enabled = true;
          };
        };

        # Signature help
        signature = {
          enabled = true;
          window = {
            border = "rounded";
          };
        };

        # Fuzzy matching
        fuzzy = {
          use_frecency = true;
          use_proximity = true;
          sorts = [
            "score"
            "sort_text"
          ];
        };

        # Sources configuration
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };

        # Keymaps
        keymap = {
          preset = "default";

          "<C-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-e>" = [ "hide" ];
          "<CR>" = [
            "accept"
            "fallback"
          ];
          "<Tab>" = [
            "snippet_forward"
            "select_next"
            "fallback"
          ];
          "<S-Tab>" = [
            "snippet_backward"
            "select_prev"
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          "<C-p>" = [
            "select_prev"
            "fallback"
          ];
          "<C-n>" = [
            "select_next"
            "fallback"
          ];
          "<C-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];
        };
      };
    };
    # Blink CMP Highlights
    luaConfigRC.blink-cmp-highlights = ''
      vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'FloatBorder' })
      vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { link = 'NormalFloat' })
      vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'FloatBorder' })

      vim.api.nvim_set_hl(0, 'BlinkCmpKindFunction', { link = 'Function' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindMethod', { link = 'Function' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindConstructor', { link = 'Function' })

      vim.api.nvim_set_hl(0, 'BlinkCmpKindVariable', { link = 'Identifier' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindField', { link = 'Identifier' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindProperty', { link = 'Identifier' })

      vim.api.nvim_set_hl(0, 'BlinkCmpKindClass', { link = 'Type' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindInterface', { link = 'Type' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindStruct', { link = 'Type' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindModule', { link = 'Include' })

      vim.api.nvim_set_hl(0, 'BlinkCmpKindUnit', { link = 'Number' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindValue', { link = 'String' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindEnum', { link = 'Type' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindEnumMember', { link = 'Constant' })

      vim.api.nvim_set_hl(0, 'BlinkCmpKindKeyword', { link = 'Keyword' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindConstant', { link = 'Constant' })

      vim.api.nvim_set_hl(0, 'BlinkCmpKindSnippet', { link = 'Special' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindColor', { link = 'Special' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindFile', { link = 'Directory' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindReference', { link = 'Special' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindFolder', { link = 'Directory' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindEvent', { link = 'Type' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindOperator', { link = 'Operator' })
      vim.api.nvim_set_hl(0, 'BlinkCmpKindTypeParameter', { link = 'Type' })
    '';
  };
}
