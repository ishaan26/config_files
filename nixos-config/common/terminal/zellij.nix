{ config, pkgs, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      # UI Configuration
      ui.pane_frames.rounded_corners = true;
      ui.pane_frames.hide_session_name = false;

      # Default shell
      default_shell = "fish";

      # Copy on select
      copy_on_select = true;
      copy_command = "wl-copy"; # Use "pbcopy" for macOS, "xclip -selection clipboard" for X11

      # Scrollback
      scrollback_editor = "${pkgs.neovim}/bin/nvim";
      scroll_buffer_size = 10000;

      # Mouse mode
      mouse_mode = true;

      # Pane frames
      pane_frames = true;

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
        normal {
            // Mode switching
            bind "Ctrl g" { SwitchToMode "locked"; }
            bind "Ctrl p" { SwitchToMode "pane"; }
            bind "Ctrl t" { SwitchToMode "tab"; }
            
            // Quick pane navigation with Alt
            bind "Alt h" { MoveFocus "Left"; }
            bind "Alt l" { MoveFocus "Right"; }
            bind "Alt j" { MoveFocus "Down"; }
            bind "Alt k" { MoveFocus "Up"; }
            
            // Quick actions
            bind "Alt n" { NewPane; }
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

    // UI Configuration
    ui {
        pane_frames {
            rounded_corners true
            hide_session_name false
        }
    }

    // Copy on select
    copy_on_select true
    copy_command "wl-copy"

    // Scrollback
    scrollback_editor "${pkgs.neovim}/bin/nvim"
    scroll_buffer_size 10000

    // Mouse mode
    mouse_mode true

    // Pane frames
    pane_frames true

    // Simplified UI
    simplified_ui false

    // Default layout
    default_layout "compact"

    // Session serialization
    session_serialization true
    serialize_pane_viewport true
    scrollback_lines_to_serialize 10000

    // Auto-layout
    auto_layout true

    // Session name in pane
    session_name_in_pane true

    // Styled underlines
    styled_underlines true
  '';

  # Create custom layouts
  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        default_tab_template {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            children
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        
        tab name="editor" focus=true {
            pane split_direction="vertical" {
                pane
                pane split_direction="horizontal" {
                    pane size="20%"
                    pane size="80%"
                }
            }
        }
        
        tab name="terminal" {
            pane
        }
    }
  '';

  xdg.configFile."zellij/layouts/ide.kdl".text = ''
    layout {
        default_tab_template {
            pane size=1 borderless=true {
                plugin location="zellij:tab-bar"
            }
            children
            pane size=2 borderless=true {
                plugin location="zellij:status-bar"
            }
        }
        
        tab name="code" focus=true {
            pane split_direction="vertical" {
                pane size="70%"
                pane split_direction="horizontal" size="30%" {
                    pane size="50%" {
                        name "terminal"
                    }
                    pane size="50%" {
                        name "tests"
                    }
                }
            }
        }
        
        tab name="files" {
            pane command="lf"
        }
        
        tab name="git" {
            pane command="lazygit"
        }
    }
  '';
}
