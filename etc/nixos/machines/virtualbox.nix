{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  networking.hostName = "virtualbox";

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/disk/by-uuid/7c46cf96-37e6-48b2-84e5-00dc9fe38337";
      fsType = "ext4";
    }
    { mountPoint = "/home";
      device = "/dev/sda3";
    }
  ];

  swapDevices = [
    # Mount the swap partition
    { device = "/dev/sda1"; }
  ];


  nix.maxJobs = 4;
  services.virtualboxGuest.enable = true;
  boot.initrd.checkJournalingFS = false;
}
