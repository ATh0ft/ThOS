{
  pkgs,
  lib,
  config,
  ...
}: let
  wallpaperPath = ../../../assets/peakpx.jpg; # Adjusted relative path
  globalWallpaper = "sddm/background.jpg"; # Will resolve to /etc/sddm/background.jpg
in {
  options = {
    sddm.enable = lib.mkEnableOption "Enable SDDM with custom background";
  };

  config = lib.mkIf config.sddm.enable {
    # Ensure the wallpaper is copied to /etc/sddm/background.jpg
    environment.etc."${globalWallpaper}".source = wallpaperPath;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    # Install Catppuccin SDDM with the custom background
    environment.systemPackages = [
      (
        pkgs.catppuccin-sddm.override {
          flavor = "mocha";
          font = "Noto Sans";
          fontSize = "9";
          background = "/etc/${globalWallpaper}"; # Path now resolves correctly
          loginBackground = true;
        }
      )
    ];
  };
}
