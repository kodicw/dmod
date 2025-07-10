{ pkgs
, namespace
, lib
, config
, ...
}:
let
  cfg = config.${namespace}.desktop.cosmic;
in
with lib;
with lib.${namespace};
{
  options.${namespace}.desktop.cosmic = {
    enable = mkEnableOption "cosmic";
  };
  config = mkIf cfg.enable {
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
