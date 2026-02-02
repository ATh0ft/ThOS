
{ pkgs, lib, config, ... }:
let
  cfg = config.zotero;
  dependencies = with pkgs; [ zotero ];

in
{
  options = {
    zotero = {
      enable = lib.mkEnableOption "Enable zotero";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };
}
