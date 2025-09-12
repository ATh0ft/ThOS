{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.basic-python;
  dependencies = with pkgs; [
    python313
    python313Packages.numpy
    python313Packages.matplotlib
  ];
in {
  imports = [];

  options = {
    basic-python = {
      enable = lib.mkEnableOption "enables python with some basic packages";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
