{ config
, lib
, pkgs
, namespace
, options
, ...
}:
let
  cfg = config.${namespace}.system.linode;
in
with lib;
with lib.${namespace};
{
  options = {
    ${namespace}.system.linode = {
      enable = mkEnableOption "Enable GRUB EFI support";
      device = mkOption {
        type = types.str;
        default = "nodev";
        description = "The device to install GRUB on";
      };
      useOSProber = mkOption {
        type = types.bool;
        default = false;
        description = "Use os-prober to detect other operating systems";
      };
      efiSupport = mkOption {
        type = types.bool;
        default = true;
        description = "Enable EFI support";
      };
    };
  };
  config = mkIf cfg.enable {
    boot = {
      # Add kernel modules detected by nixos-generate-config:
      initrd.availableKernelModules = [
        "virtio_pci"
        "virtio_scsi"
        "ahci"
        "sd_mod"
      ];

      growPartition = true;

      # Set up LISH serial connection:
      kernelParams = [ "console=ttyS0,19200n8" ];

      loader = {
        # Increase timeout to allow LISH connection:
        timeout = lib.mkForce 10;

        grub = {
          enable = true;
          forceInstall = true;
          device = "nodev";
          fsIdentifier = "label";

          # Allow serial connection for GRUB to be able to use LISH:
          extraConfig = ''
            serial --speed=19200 --unit=0 --word=8 --parity=no --stop=1;
            terminal_input serial;
            terminal_output serial
          '';

          # Link /boot/grub2 to /boot/grub:
          extraInstallCommands = ''
            ${pkgs.coreutils}/bin/ln -fs /boot/grub /boot/grub2
          '';

          # Remove GRUB splash image:
          splashImage = null;
        };
      };
    };

    # Hardware option detected by nixos-generate-config:
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    # Install diagnostic tools for Linode support:
    environment.systemPackages = with pkgs; [
      inetutils
      mtr
      sysstat
      linode-cli
    ];

    networking = {
      enableIPv6 = true;
      tempAddresses = "disabled";
      useDHCP = true;
      usePredictableInterfaceNames = false;
      interfaces.eth0 = {
        tempAddress = "disabled";
        useDHCP = true;
      };
    };

    services.qemuGuest.enable = true;
  };
}

