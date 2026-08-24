{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home_manager_modules/default.nix
  ];

  home.username = "ai"; # Replace with your actual username
  home.homeDirectory = "/home/ai"; # Ensure this matches your home directory
  home.stateVersion = "25.05"; # Adjust this based on your NixOS version
  latex.enable = false;
  foliate.enable = true;
  nvf.enable = true;
  gimp.enable = false;
  zotero.enable = true;
  obsidian.enable = true;

}
