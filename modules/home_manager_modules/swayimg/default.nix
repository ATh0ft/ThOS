{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: let
  cfg = config.swayimg;
  dependencies = [
    pkgs.swayimg
  ];
in {
  options = {
    swayimg.enable = lib.mkEnableOption "enables swayimg";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
