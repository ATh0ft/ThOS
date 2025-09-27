{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.go-mono
  ];
}
