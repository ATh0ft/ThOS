{
  config,
  pkgs,
  ...
}: {
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
  };

  # Install essential packages
  environment.systemPackages = with pkgs; [
    hyprland
    hyprpaper # Wallpaper utility
    hyprlock # Lock screen
    hypridle # Idle manager
    waybar # Status bar
    wofi # Application launcher
    kitty # Terminal
    alacritty
    dunst # Notifications
    rofi-wayland # Alternative launcher
    firefox # Browser
    swww # Wallpaper manager
    wl-clipboard # Clipboard support
    grim
    slurp # Screenshots
    mako # Notification daemo
    brightnessctl
  ];

  # Enable seatd for non-root user access to input devices
  services.seatd.enable = true;

  # Configure XDG portal for Wayland
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-wlr];
  };

  # Enable Polkit (needed for GUI applications to request permissions)
  security.polkit.enable = true;

  # Ensure the user is in the right groups for Wayland access
  users.users.a = {
    isNormalUser = true;
    extraGroups = ["seat" "video" "input" "wheel"];
  };
}
