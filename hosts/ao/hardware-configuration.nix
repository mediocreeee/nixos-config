# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    # device = "/dev/disk/by-uuid/74e3c0f2-0896-4f1e-9b7c-d1d7c12a5ec0";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    # device = "/dev/disk/by-uuid/50C0-0978";
    fsType = "vfat";
  };

  fileSystems."/home/${config.user.name}/vids" = {
    # fileSystems."/mnt/media" = {
    device = "/dev/disk/by-label/media";
    # device = "/dev/disk/by-uuid/98b85d86-ad1b-4d4f-9ba3-14a7701a7a5a";
    ### FIXME Line below brakes everything
    # options = [ "uid=1000" "gid=100" "dmask=007" "fmask=117" ];
    # options = [ "defaults" "user" "rw" "utf8" "noauto" "umask=000" ];
    fsType = "ext4";
  };

  swapDevices = [ ];

}
