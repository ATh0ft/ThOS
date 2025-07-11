{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home_manager_modules/default.nix
  ];

  home.username = "a"; # Replace with your actual username
  home.homeDirectory = "/home/a"; # Ensure this matches your home directory
  home.stateVersion = "23.11"; # Adjust this based on your NixOS version
  #foliate.enable = true;
  evince.enable = true;
  latex.enable = true;
  foliate.enable = true;
  direnv.enable = true;
  swayimg.enable = true;
  # Enable Firefox settings
  programs.firefox = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      grep = "grep --color=auto";
    };
  };
  nvf.enable = true;
  nm-applet.enable = true;

  xdg.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
