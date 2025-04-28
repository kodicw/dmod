# nix run github:nix-community/nixos-anywhere -- --flake '.#infra-wall' --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --target-host root@192.168.1.218
{ lib
, namespace
, ...
}:
{
  imports = [
    ./hardware.nix
  ];

  ${namespace} = {
    packs.cli = {
      enable = true;
    };
    services.telegraf.enable = true;

  };

  nixpkgs.config = {
    allowUnfree = true;
  };
  services.mingetty.autologinUser = "root";

  networking = {
    nftables.enable = true;
    hostName = "test1";
  };

  system.stateVersion = "24.11";
}

