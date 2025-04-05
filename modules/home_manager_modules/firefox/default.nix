{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.firefox;
in {
  imports = [
    # Ensure Firefox module is imported only once
    # inputs.textfox.homeManagerModules.default
  ];

  options = {
    firefox.enable = lib.mkEnableOption "enables firefox";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {

      xdg = {
        enable = true;
        mimeApps.enable = true;
        mimeApps.defaultApplications = {
          "text/html" = ["firefox.desktop"];
          "text/xml" = ["firefox.desktop"];
          "x-scheme-handler/http" = ["firefox.desktop"];
          "x-scheme-handler/https" = ["firefox.desktop"];
        };
      };
    }
  ]);
}

