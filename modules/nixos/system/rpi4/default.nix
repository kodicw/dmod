{ options
, config
, pkgs
, lib
, namespace
, ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.system.rpi4;
in
{
  options.${namespace}.system.rpi4 = {
    enable = mkEnableOption "needed config for rpi4";
  };
  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
      initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
      loader = {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      };
    };
    hardware.enableRedistributableFirmware = true;
  };
}
