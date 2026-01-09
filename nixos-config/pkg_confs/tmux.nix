{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Use a modern tmux version
    terminal = "tmux-256color";

    # Set prefix to Ctrl-b (default, but explicit)
    prefix = "C-b";

    # Enable mouse support
    mouse = true;

    # Increase history limit
    historyLimit = 50000;

    # Start window numbering at 1 instead of 0
    baseIndex = 1;

    # Renumber windows when one is closed
    escapeTime = 0;

    # Enable focus events for better vim integration
    focusEvents = true;

    plugins = with pkgs.tmuxPlugins; [
      # Session management and restoration
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      # Better pane navigation
      vim-tmux-navigator
      # Sensible defaults
      sensible
      # Yank support
      yank
    ];

    extraConfig = ''
       # ============================================
       # GENERAL SETTINGS
       # ============================================

       # Enable true color support
       set -ga terminal-overrides ",*256col*:Tc"
       set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
       set-environment -g COLORTERM "truecolor"

       # Set window and pane index to start at 1
       set -g pane-base-index 1
       set-window-option -g pane-base-index 1
       set-option -g renumber-windows on

       # Reduce escape time for better vim experience
       set -sg escape-time 0

       # Increase repeat time for repeatable commands
       set -g repeat-time 1000

       # Enable aggressive resize
       setw -g aggressive-resize on

       # ============================================
       # KEY BINDINGS
       # ============================================

       # Reload config with prefix + r
       bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

       # Create new window with Ctrl-b + c (default, but confirming)
       bind c new-window -c "#{pane_current_path}"

       # Alt+h and Alt+l to switch windows (tabs)
       bind -n M-h previous-window
       bind -n M-l next-window

       # Better window splitting
       bind | split-window -h -c "#{pane_current_path}"
       bind - split-window -v -c "#{pane_current_path}"
       unbind '"'
       unbind %

       # Vim-like pane navigation
       bind h select-pane -L
       bind j select-pane -D
       bind k select-pane -U
       bind l select-pane -R

       # Pane resizing with vim keys
       bind -r H resize-pane -L 5
       bind -r J resize-pane -D 5
       bind -r K resize-pane -U 5
       bind -r L resize-pane -R 5

       # Quick pane cycling
       bind -r C-h select-window -t :-
       bind -r C-l select-window -t :+

       # Kill pane without confirmation
       bind x kill-pane

       # Kill window without confirmation
       bind X kill-window

       # Swap windows
       bind -r "<" swap-window -d -t -1
       bind -r ">" swap-window -d -t +1

       # Copy mode vim bindings
       setw -g mode-keys vi
       bind -T copy-mode-vi v send-keys -X begin-selection
       bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
       bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

       # Enter copy mode with prefix + [
       bind [ copy-mode

       # Paste with prefix + ]
       bind ] paste-buffer

       # ============================================
       # STATUS BAR (Stylix will override colors)
       # ============================================

       # Status bar position
       set -g status-position bottom

       # Update status bar every second
       set -g status-interval 1

       # Center the window list
       set -g status-justify left

       # Status bar length
       set -g status-left-length 100
       set -g status-right-length 100

      # Window status format
       setw -g window-status-format " #I:#W "
       setw -g window-status-current-format "#[bg=${config.lib.stylix.colors.base0D},fg=${config.lib.stylix.colors.base00},bold] #I:#W #[nobold]"

       # Pane border format
       set -g pane-border-status off

       # ============================================
       # DISPLAY
       # ============================================

       # Set window notifications
       setw -g monitor-activity on
       set -g visual-activity off

       # Display tmux messages for 2 seconds
       set -g display-time 2000

       # Display pane numbers for 1 second
       set -g display-panes-time 1000

       # Disable bell
       set -g bell-action none
       set -g visual-bell off

       # Set titles
       set -g set-titles on
       set -g set-titles-string "#T"

       # ============================================
       # PERFORMANCE
       # ============================================

       # Increase buffer size
       set -g buffer-limit 20

       # Don't constrain window size
       setw -g aggressive-resize on
    '';
  };
}
