{ pkgs, lib, config, ... }:
let
  cfg = config.foliate;
  dependencies = with pkgs; [ foliate ];
in
{
  options = {
    foliate = {
      foliate = lib.mkEnableOption "Enable foliate";
    };
  };
  config = lib.mkIf cfg.enable {
    home = {
      packages = dependencies;
    };
  };

}
