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
  # foliate.enable = true;
  # Enable Firefox settings
  programs.firefox = {
    enable = true;
  };
  nvf.enable = true;

  #  home.file.".mozilla/startpage" = {
  #    source = ./sources/startpage;
  #    executable = false;
  #    recursive = true;
  #  };

  #  evince.enable = true;

  xdg.enable = true;
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };
}
