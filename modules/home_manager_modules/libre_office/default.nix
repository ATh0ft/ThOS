{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.libreoffice-qt;
  dependencies = with pkgs; [
    hunspell
    hunspellDicts.en_US
  ];
in {
  imports = [];

  options = {
    libreoffice-qt = {
      enable = lib.mkEnableOption "enables libre office";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home.packages = dependencies;
    }
  ]);
}
