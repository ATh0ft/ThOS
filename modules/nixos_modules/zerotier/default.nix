{ pkgs, lib, config, ... }:

let
  networkIdFile = config.age.secrets.zerotier-network-id.path or "/dev/null";
in {
  options = {
    zerotierone.enable = lib.mkEnableOption "Enable Zerotier";
  };

  config = lib.mkIf config.zerotierone.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = [ "@zerotier-network-id@" ]; # placeholder
    };

    # Activation script to replace the placeholder with actual secret
    system.activationScripts.zerotier-network-id = ''
      secret=$(cat "${networkIdFile}")
      cfgFile="/etc/zerotier-one/networks.d/zerotier.conf" # Adjust if needed
      if [ -f "$cfgFile" ]; then
        ${pkgs.gnused}/bin/sed -i "s#@zerotier-network-id@#$secret#" "$cfgFile"
      fi
    '';
  };
}

