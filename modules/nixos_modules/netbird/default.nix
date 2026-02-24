{ config, pkgs, ... }:

{
  # Install Git
  environment.systemPackages = with pkgs; [ netbird ];

  # Optional: Configure Git globally

}
