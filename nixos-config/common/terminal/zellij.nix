{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      show_startup_tips = false;

      pane_frames = false;

      # Default shell
      default_shell = "fish";

      # Copy on select
      copy_on_select = true;
      copy_command = if pkgs.stdenv.isDarwin then
        "pbcopy"
      else if builtins.getEnv "WAYLAND_DISPLAY" != "" then
        "wl-copy"
      else
        "xclip -selection clipboard";

      # Scrollback
      scrollback_editor = "${pkgs.neovim}/bin/nvim";
      scroll_buffer_size = 10000;

      # Mouse mode
      mouse_mode = true;

      # Simplified UI
      simplified_ui = false;

      # Default layout
      default_layout = "compact";

      # Default mode
      default_mode = "normal";

      # Session serialization
      session_serialization = true;
      serialize_pane_viewport = true;
      scrollback_lines_to_serialize = 10000;

      # Auto-layout
      auto_layout = true;

      # Session name in pane
      session_name_in_pane = true;

      # Styled underlines
      styled_underlines = true;
    };
  };

  # Create the KDL config file directly for keybindings
  xdg.configFile."zellij/config.kdl".text = ''
    // Streamlined keybindings configuration
    keybinds {
        unbind "Ctrl h" // Used inside vim

        shared_except "locked" {
            // TODO: fuzzy finder
            // bind "Ctrl f" { SwitchToMode "search"; }
        }

        
        normal {
            // Mode switching
            bind "Ctrl g" { SwitchToMode "locked"; }
            bind "Ctrl p" { SwitchToMode "pane"; }
            bind "Ctrl t" { SwitchToMode "tab"; }
            
            // Quick pane navigation with Alt
            bind "Alt h" { GoToPreviousTab; }    
            bind "Alt l" { GoToNextTab; }        
            
            // Quick actions
            bind "Alt n" { NewTab; }
            bind "Alt [" { PreviousSwapLayout; }
            bind "Alt ]" { NextSwapLayout; }
        }

        locked {
            bind "Ctrl g" { SwitchToMode "normal"; }
        }

        pane {
            bind "Esc" { SwitchToMode "normal"; }
            bind "h" { MoveFocus "Left"; }
            bind "l" { MoveFocus "Right"; }
            bind "j" { MoveFocus "Down"; }
            bind "k" { MoveFocus "Up"; }
            bind "n" { NewPane; SwitchToMode "normal"; }
            bind "x" { CloseFocus; SwitchToMode "normal"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "normal"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "normal"; }
        }

        tab {
            bind "Esc" { SwitchToMode "normal"; }
            bind "h" { GoToPreviousTab; }
            bind "l" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "normal"; }
            bind "x" { CloseTab; SwitchToMode "normal"; }
            bind "1" { GoToTab 1; SwitchToMode "normal"; }
            bind "2" { GoToTab 2; SwitchToMode "normal"; }
            bind "3" { GoToTab 3; SwitchToMode "normal"; }
            bind "4" { GoToTab 4; SwitchToMode "normal"; }
            bind "5" { GoToTab 5; SwitchToMode "normal"; }
        }
    }
  '';
}
