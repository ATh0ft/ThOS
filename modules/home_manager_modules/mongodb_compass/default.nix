{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.mongodb-compass;
  dependencies = with pkgs; [mongodb-compass];
in {
  options = {
    mongodb-compass = {
      enable = lib.mkEnableOption "Enable MongoDB Compass";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
