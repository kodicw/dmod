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
  openPorts = [ 8443 ];
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
    };
    networking = {
      bridges = {
        "${bridge-interface}" = {
          interfaces = cfg.bridgeInterfaces; # Replace with your physical interface
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
