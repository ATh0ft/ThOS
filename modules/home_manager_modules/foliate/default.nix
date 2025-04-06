{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.foliate;
  dependencies = with pkgs; [foliate];
in {
  options = {
    foliate.enable = lib.mkEnableOption "enable calculator";
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;
  };
}
