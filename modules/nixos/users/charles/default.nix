{ config, pkgs, lib, namespace, ... }:
let
  groups = [
    "networkmanager"
    "wheel"
    "libvirtd"
    "docker"
    "audio"
    "dialout"
  ];
  cfg = config.${namespace}.users.charles;
in
with lib;
{
  options = {
    ${namespace}.users.charles.enable = mkEnableOption "Enable user charles";
  };
  config = mkIf cfg.enable {
    users = {
      users = {
        charles = {
          isNormalUser = true;
          packages = [ pkgs.helix ];
          shell = pkgs.nushell;
          useDefaultShell = true;
          initialHashedPassword = "$y$j9T$gSxRpeHmBy9Qt8Iz0gkEE0$6RYzT2krsz8HiAk.X.q3AVkMwpOL85FkayNFt.6saC4";
          description = "charles";
          extraGroups = groups;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiDe2CMnDgWjXqMpQHxCSOmrjuAWwZazYPORZXlr2SF u0_a518@localhost"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFv8kP8LWCSGweBHEl/AmxKMLat2Y2RWonKqDSO6RrWb charles@mainframe"
          ];
        };
      };
    };
  };
}

