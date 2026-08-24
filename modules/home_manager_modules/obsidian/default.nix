{ pkgs, lib, config, ... }:

let
  cfg = config.obsidian;
in
{
  options.obsidian = {
    enable = lib.mkEnableOption "Enable Obsidian";
  };

  config = lib.mkIf cfg.enable {
    programs.obsidian = {
      enable = true;

      vaults.notes.target = "Documents/Obsidian";

      defaultSettings.app = {
        alwaysUpdateLinks = true;
        spellcheck = true;
      };
    };
  };
}
