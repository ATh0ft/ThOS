{ config, pkgs, ... }:

let
  # Set the Rose Pine theme as tmux configuration
  rosePineTmuxConfig = ''
    # Enable mouse support
    set -g mouse on

    # Rose Pine theme
    set -g status-style bg=dark,fg=white
    set -g window-status-style fg=#ebbcba,bg=#232136
    set -g window-status-current-style fg=#9ccfd8,bg=#232136
    set -g status-right-style fg=#9ccfd8,bg=#232136
    set -g status-left-style fg=#9ccfd8,bg=#232136
    set -g message-bg-color #232136
    set -g message-fg-color #ebbcba
    set -g pane-border-style fg=#232136
    set -g pane-active-border-style fg=#9ccfd8
    set -g status-style fg=#ebbcba,bg=#232136

    # Tmux Plugin Manager (TPM) configuration
    # Install TPM automatically
    run-shell "mkdir -p ~/.tmux/plugins"
    run-shell "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"

    # Plugin list, can be modified later
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'   # Example plugin
    set -g @plugin 'tmux-plugins/tmux-resurrect'  # Example plugin

    # Initialize TPM
    run-shell "~/.tmux/plugins/tpm/tpm"
  '';
in
{
  # Enable tmux
  programs.tmux = {
    enable = true;

    # Create the tmux configuration file with Rose Pine theme and mouse support
    extraConfig = rosePineTmuxConfig;
  };
}

