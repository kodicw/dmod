{ config
, lib
, namespace
, ...
}:
let
  cfg = config.${namespace}.services.telegraf;
in
{
  options = {
    ${namespace}.services.telegraf = {
      urls = with lib; mkOption {
        type = with types; listOf str;
        default = "http://127.0.0.1:8086";
        description = "List of urls for influxdb api";
      };
    };
  };
  config = lib.mkIf cfg.enable {
    services.telegraf = {
      inputs = {
        netstat = {};
        socketstat = {
          protocols = [ "tcp" "udp" ];
        };
        cpu = {};
        mem = {};
        disk = {};
        processes = {};
        smart = {};
        system = {};
        systemd_units = {};
      };
      outputs = {
        influxdb_v2 = {
          urls = cfg.urls;
        };
      };
    };
  };
}

