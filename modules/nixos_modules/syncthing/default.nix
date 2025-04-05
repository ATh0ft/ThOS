{ pkgs, lib, config, ... }: {
  options = {
    syncthing.enable = lib.mkEnableOption "enables syncthing";
  };
  config = lib.mkIf config.syncthing.enable {
    services.syncthing = {
      enable = true;
      dataDir = "/home/a/sync";
      user = "a";
      configDir = "/home/a/.config/syncthing";
      settings = {
        gui = {
          user = "a";
        };
      };
    };
  };
}
