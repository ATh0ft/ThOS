{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.nm-applet;
  dependencies = with pkgs; [networkmanagerapplet];
in {
  options = {
    nm-applet.enable = lib.mkEnableOption "enable nm gtk app";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
