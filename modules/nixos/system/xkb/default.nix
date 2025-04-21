{ options
, config
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.xkb;
in
{
  options.${namespace}.system.xkb = {
    enable = mkEnableOption "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      xkb.layout = "us";
      xkb.options = "caps:escape";
    };
  };
}
