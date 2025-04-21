{ config, lib, pkgs, namespace, ... }:
let
  cfg = config.${namespace}.users.root;
in
with lib;
{
  options = {
    ${namespace}.users.root = {
      enable = mkEnableOption "Enable root";
      sshKeys = mkOption {
        type = types.listOf types.str;
        default = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv8kP8LWCSGweBHEl/AmxKMLat2Y2RWonKqDSO6RrWb charles@mainframe"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcgbJ626wZZs5aE9kbIc97LhDz9yeb/MmRPnYybpwJK root@mainframe"
        ];
        description = "List of SSH keys to add to the root user";
      };
    };
  };
  config = mkIf cfg.enable {
    users.users.root.openssh.authorizedKeys.keys = cfg.sshKeys;
  };
}

