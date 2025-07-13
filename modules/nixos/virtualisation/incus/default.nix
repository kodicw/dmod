{ options
, config
, lib
, pkgs
, namespace
, ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.virtualisation.incus;
  bridge-interface = "incusbr0";
  openPorts = [ 8443 443 80 ];
in
{
  options.${namespace}.virtualisation.incus = {
    enable = mkEnableOption "Whether or not to enable incus.";
    ui = mkEnableOption "Enable ui";
    package = mkOption {
      type = types.package;
      default = pkgs.incus;
      description = "Package version for incus";
    };
    bridgedInterfaces = mkOption {
      type = types.listOf types.str;
      description = "List of interfaces to be used for container networking";
    };
    manageBridge = mkOption {
      type = types.bool;
      default = true;
      description = "Whether Incus should manage its own default bridge (e.g., incusbr0 with internal DHCP). Set to false if you are externally managing a bridge (e.g., via networking.bridges).";
    };
  };
  config = mkIf cfg.enable {
    users.users.root.subGidRanges = lib.mkForce [
      { count = 1; startGid = 100; }
      { count = 1000000000; startGid = 1000000; }
    ];
    users.users.root.subUidRanges = lib.mkForce [
      { count = 1; startUid = 1000; }
      { count = 1000000000; startUid = 1000000; }
    ];
    environment.systemPackages = with pkgs; [
      nfs-utils
      nettools
      zfs
      sshfs
      openvswitch
    ];
    virtualisation.incus = {
      enable = true;
      ui.enable = cfg.ui;
      package = pkgs.incus;
      preseed = mkIf (!cfg.manageBridge) {
        networks = []; # No default networks managed by Incus itself
      };
    };
    networking = {
      networkmanager.unmanaged = cfg.bridgedInterfaces;
      bridges = {
        "${bridge-interface}" = {
            interfaces = cfg.bridgedInterfaces; # Replace with your physical interface
            useDHCP = true;
        };
      };
      nftables.enable = true;
      firewall = {
        interfaces."${bridge-interface}" = {
          allowedTCPPorts = [ 53 67 ];
          allowedUDPPorts = [ 53 67 ];
        };
        enable = true;
        allowedTCPPorts = openPorts;
        trustedInterfaces = [
          bridge-interface
        ];
      };
    };
  };
}
