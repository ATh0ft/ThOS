{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.basic-python;
  pythonEnv = pkgs.python313.withPackages (ps:
    with ps; [
      numpy
      matplotlib
    ]);
in {
  options.basic-python.enable =
    lib.mkEnableOption "Enable Python with some basic packages";

  config = lib.mkIf cfg.enable {
    home.packages = [pythonEnv];
  };
}
