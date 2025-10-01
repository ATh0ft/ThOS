{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home_manager_modules/default.nix
  ];

  home.username = "atc"; # Replace with your actual username
  home.homeDirectory = "/home/atc"; # Ensure this matches your home directory
  home.stateVersion = "25.05"; # Adjust this based on your NixOS version
  latex.enable = true;
  foliate.enable = true;
  nvf.enable = true;
  gimp.enable = true;
  mongodb-compass.enable = true;

  home.packages = with pkgs; [
    home-manager
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.go-mono
  ];

  # home.fonts.packages = with pkgs; [
  #   nerd-fonts.fira-code
  #   nerd-fonts.droid-sans-mono
  #   nerd-fonts.go-mono
  # ];
}
