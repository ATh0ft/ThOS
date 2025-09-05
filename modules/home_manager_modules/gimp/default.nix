{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.gimp;
  dependencies = with pkgs; [gimp];
in {
  options = {
    gimp = {
      enable = lib.mkEnableOption "Enable gimp";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
