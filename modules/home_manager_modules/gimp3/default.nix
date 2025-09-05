{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.gimp3;
  dependencies = with pkgs; [gimp3];
in {
  options = {
    gimp3 = {
      enable = lib.mkEnableOption "Enable evince";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
