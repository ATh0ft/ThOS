{
  config,
  pkgs,
  ...
}: let
  # Set the Rose Pine theme as tmux configuration
  rosePineTmuxConfig = ''
    # Enable mouse support
    set -g mouse on
    # Rose Pine theme
    set -g pane-border-style fg=#232136
    set -g pane-active-border-style fg=#9ccfd8
    set -g status-style fg=#ebbcba,bg=#232136

    # make colors pwetty again for alacritty terminal
    set -g default-terminal "tmux-256color"
    set-option -a terminal-features 'alacritty:RGB'
    # Compatibility fallback for older tools
    set-option -ga terminal-overrides ",alacritty:Tc"

    # Status bar
    set-option -g status-position top
    set -g base-index 1
    setw -g pane-base-index 1
    set -g status-separator " |"

    # keybinds
    unbind C-b
    set -g prefix C-Space


    # Tmux Plugin Manager (TPM) configuration
    # Install TPM automatically
    run-shell "mkdir -p ~/.tmux/plugins"
    run-shell "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"

    # Plugin list, can be modified later
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'   # Example plugin

    # Initialize TPM
    run-shell "~/.tmux/plugins/tpm/tpm"
  '';
in {
  # Enable tmux
  programs.tmux = {
    enable = true;

    # Create the tmux configuration file with Rose Pine theme and mouse support
    extraConfig = rosePineTmuxConfig;
  };
}
