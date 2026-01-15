{ pkgs, config, ... }:

let
  inherit (config.lib.stylix) colors;

  sesh = pkgs.writeScriptBin "sesh" ''
    #! /usr/bin/env sh

    # Taken from https://github.com/zellij-org/zellij/issues/884#issuecomment-1851136980
    # select a directory using zoxide
    ZOXIDE_RESULT=$(zoxide query --interactive)
    # checks whether a directory has been selected
    if [[ -z "$ZOXIDE_RESULT" ]]; then
    	# if there was no directory, select returns without executing
    	exit 0
    fi
    # extracts the directory name from the absolute path
    SESSION_TITLE=$(echo "$ZOXIDE_RESULT" | sed 's#.*/##')

    # get the list of sessions
    SESSION_LIST=$(zellij list-sessions -n | awk '{print $1}')

    # checks if SESSION_TITLE is in the session list
    if echo "$SESSION_LIST" | grep -q "^$SESSION_TITLE$"; then
    	# if so, attach to existing session
    	zellij attach "$SESSION_TITLE"
    else
    	# if not, create a new session
    	echo "Creating new session $SESSION_TITLE and CD $ZOXIDE_RESULT"
    	cd $ZOXIDE_RESULT
    	zellij attach -c "$SESSION_TITLE"
    fi
  '';

in
{
  home.packages = [
    pkgs.tmate
    sesh
  ];
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

  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        swap_tiled_layout name="vertical" {
            tab max_panes=5 {
                pane split_direction="vertical" {
                    pane
                    pane { children; }
                }
            }
            tab max_panes=8 {
                pane split_direction="vertical" {
                    pane { children; }
                    pane { pane; pane; pane; pane; }
                }
            }
            tab max_panes=12 {
                pane split_direction="vertical" {
                    pane { children; }
                    pane { pane; pane; pane; pane; }
                    pane { pane; pane; pane; pane; }
                }
            }
        }

        swap_tiled_layout name="horizontal" {
            tab max_panes=5 {
                pane
                pane
            }
            tab max_panes=8 {
                pane {
                    pane split_direction="vertical" { children; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                }
            }
            tab max_panes=12 {
                pane {
                    pane split_direction="vertical" { children; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                }
            }
        }

        swap_tiled_layout name="stacked" {
            tab min_panes=5 {
                pane split_direction="vertical" {
                    pane
                    pane stacked=true { children; }
                }
            }
        }

        swap_floating_layout name="staggered" {
            floating_panes
        }

        swap_floating_layout name="enlarged" {
            floating_panes max_panes=10 {
                pane { x "5%"; y 1; width "90%"; height "90%"; }
                pane { x "5%"; y 2; width "90%"; height "90%"; }
                pane { x "5%"; y 3; width "90%"; height "90%"; }
                pane { x "5%"; y 4; width "90%"; height "90%"; }
                pane { x "5%"; y 5; width "90%"; height "90%"; }
                pane { x "5%"; y 6; width "90%"; height "90%"; }
                pane { x "5%"; y 7; width "90%"; height "90%"; }
                pane { x "5%"; y 8; width "90%"; height "90%"; }
                pane { x "5%"; y 9; width "90%"; height "90%"; }
                pane focus=true { x 10; y 10; width "90%"; height "90%"; }
            }
        }

        swap_floating_layout name="spread" {
            floating_panes max_panes=1 {
                pane {y "50%"; x "50%"; }
            }
            floating_panes max_panes=2 {
                pane { x "1%"; y "25%"; width "45%"; }
                pane { x "50%"; y "25%"; width "45%"; }
            }
            floating_panes max_panes=3 {
                pane focus=true { y "55%"; width "45%"; height "45%"; }
                pane { x "1%"; y "1%"; width "45%"; }
                pane { x "50%"; y "1%"; width "45%"; }
            }
            floating_panes max_panes=4 {
                pane { x "1%"; y "55%"; width "45%"; height "45%"; }
                pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
                pane { x "1%"; y "1%"; width "45%"; height "45%"; }
                pane { x "50%"; y "1%"; width "45%"; height "45%"; }
            }
        }

        default_tab_template {
            children
            pane size=2 borderless=true {
                plugin location="file://${pkgs.zjstatus}/bin/zjstatus.wasm" {
                    format_left   "{mode}#[bg=#000000]{tabs}"
                    format_center ""
                      format_right  "#[bg=#${colors.base00},fg=#${colors.base0D}]#[bg=#${colors.base0D},fg=#${colors.base01},bold]  #[bg=#${colors.base02},fg=#${colors.base05},bold] {session} #[bg=#${colors.base03},fg=#${colors.base05},bold]"
                    format_space  "#[bg=#000000]"
                    format_hide_on_overlength "true"
                    format_precedence "crl"

                    border_enabled  "false"
                    border_char     "─"
                    border_format   "#[fg=#6C7086]{char}"
                    border_position "top"

                    mode_normal        "#[bg=#${colors.base0B},fg=#${colors.base02},bold] NORMAL #[bg=#000000,fg=#${colors.base0B}]█"
                    mode_locked        "#[bg=#${colors.base04},fg=#${colors.base02},bold] LOCKED #[bg=#000000,fg=#${colors.base04}]█"
                    mode_resize        "#[bg=#${colors.base08},fg=#${colors.base02},bold] RESIZE #[bg=#000000,fg=#${colors.base08}]█"
                    mode_pane          "#[bg=#${colors.base0D},fg=#${colors.base02},bold] PANE #[bg=#000000,fg=#${colors.base0D}]█"
                    mode_tab           "#[bg=#${colors.base07},fg=#${colors.base02},bold] TAB #[bg=#000000,fg=#${colors.base07}]█"
                    mode_scroll        "#[bg=#${colors.base0A},fg=#${colors.base02},bold] SCROLL #[bg=#000000,fg=#${colors.base0A}]█"
                    mode_enter_search  "#[bg=#${colors.base0D},fg=#${colors.base02},bold] ENT-SEARCH #[bg=#000000,fg=#${colors.base0D}]█"
                    mode_search        "#[bg=#${colors.base0D},fg=#${colors.base02},bold] SEARCH #[bg=#000000,fg=#${colors.base0D}]█"
                    mode_rename_tab    "#[bg=#${colors.base07},fg=#${colors.base02},bold] RENAME-TAB #[bg=#000000,fg=#${colors.base07}]█"
                    mode_rename_pane   "#[bg=#${colors.base0D},fg=#${colors.base02},bold] RENAME-PANE #[bg=#000000,fg=#${colors.base0D}]█"
                    mode_session       "#[bg=#${colors.base0E},fg=#${colors.base02},bold] SESSION #[bg=#000000,fg=#${colors.base0E}]█"
                    mode_move          "#[bg=#${colors.base0F},fg=#${colors.base02},bold] MOVE #[bg=#000000,fg=#${colors.base0F}]█"
                    mode_prompt        "#[bg=#${colors.base0D},fg=#${colors.base02},bold] PROMPT #[bg=#000000,fg=#${colors.base0D}]█"
                    mode_tmux          "#[bg=#${colors.base09},fg=#${colors.base02},bold] TMUX #[bg=#000000,fg=#${colors.base09}]█"

                    // formatting for inactive tabs
                    tab_normal              "#[bg=#000000,fg=#${colors.base0D}]█#[bg=#${colors.base0D},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{floating_indicator}#[bg=#000000,fg=#${colors.base02}]█"
                    tab_normal_fullscreen   "#[bg=#000000,fg=#${colors.base0D}]█#[bg=#${colors.base0D},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{fullscreen_indicator}#[bg=#000000,fg=#${colors.base02}]█"
                    tab_normal_sync         "#[bg=#000000,fg=#${colors.base0D}]█#[bg=#${colors.base0D},fg=#${colors.base02},bold]{index} #[bg=#${colors.base02},fg=#${colors.base05},bold] {name}{sync_indicator}#[bg=#000000,fg=#${colors.base02}]█"

                    // formatting for the current active tab
                    tab_active              "#[bg=#000000,fg=#${colors.base09}]█#[bg=#${colors.base09},fg=#${colors.base02},bold]{index} |#[bg=#${colors.base09},fg=#${colors.base02},bold] {name}{floating_indicator}#[bg=#000000,fg=#${colors.base09}]█"
                    tab_active_fullscreen   "#[bg=#000000,fg=#${colors.base09}]█#[bg=#${colors.base09},fg=#${colors.base02},bold]{index} |#[bg=#${colors.base09},fg=#${colors.base02},bold] {name}{fullscreen_indicator}#[bg=#000000,fg=#${colors.base09}]█"
                    tab_active_sync         "#[bg=#000000,fg=#${colors.base09}]█#[bg=#${colors.base09},fg=#${colors.base02},bold]{index} |#[bg=#${colors.base09},fg=#${colors.base02},bold] {name}{sync_indicator}#[bg=#000000,fg=#${colors.base09}]█"

                    // separator between the tabs
                    tab_separator           "#[bg=#000000]"

                    // indicators
                    tab_sync_indicator       " "
                    tab_fullscreen_indicator " 󰊓"
                    tab_floating_indicator   " 󰹙"

                    command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
                    command_git_branch_format      "#[fg=blue] {stdout} "
                    command_git_branch_interval    "10"
                    command_git_branch_rendermode  "static"

                    datetime        "#[fg=#6C7086,bold] {format} "
                    datetime_format "%A, %d %b %Y %H:%M"
                    datetime_timezone "Europe/London"
                }
            }
        }
    }
  '';

  programs.zellij = {
    enable = true;

    settings = {
      show_startup_tips = false;

      pane_frames = false;

      # Default shell
      default_shell = "fish";

      # Copy on select
      copy_on_select = true;
      copy_command =
        if pkgs.stdenv.isDarwin then
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
      default_layout = "default";

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
}
