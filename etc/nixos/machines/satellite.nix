{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.loader.grub.extraEntriesBeforeNixOS = true;
  boot.loader.grub.extraEntries = ''
    menuentry 'Linux Mint 17.2 Cinnamon 32-bit, with Linux 3.16.0-38-generic' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-3.16.0-38-generic-advanced-6f28574f-ca87-4$ca87-4a40-b108-8777e33b1797' {
      insmod gzio
      insmod part_msdos
      insmod ext2
      set root='hd0,msdos4'
      if [ x$feature_platform_search_hint = xy ]; then
        search --no-floppy --fs-uuid --set=root --hint-bios=hd0,msdos4 --hint-efi=hd0,msdos4 --hint-baremetal=ahci0,msdos4  6f28574f-ca87-4a40-b108-8777e33b1797
      else
        search --no-floppy --fs-uuid --set=root 6f28574f-ca87-4a40-b108-8777e33b1797
      fi
      echo    'Loading Linux 3.16.0-38-generic ...'
      linux   /boot/vmlinuz-3.16.0-38-generic root=UUID=6f28574f-ca87-4a40-b108-8777e33b1797 ro  quiet splash $vt_handoff
      echo    'Loading initial ramdisk ...'
      initrd  /boot/initrd.img-3.16.0-38-generic
    }

    menuentry "Windows XP" {
      insmod chain
      insmod ntfs
      set root='(hd0,1)'
      chainloader +1
    }
  '';

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "firewire_ohci" "tifm_7xx1" "usb_storage" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  networking.hostName = "satellite";
  networking.hostId = "2c63bc67";
  networking.networkmanager.enable = true;

  fileSystems = [
    { mountPoint = "/";
      device = "/dev/disk/by-uuid/28b4193b-98c5-4aac-bf45-485e7f74a43f";
      fsType = "ext4";
    }
    { mountPoint = "/home";
      device = "/dev/sda3";
    }
  ];

  swapDevices = [ ];

  nix.maxJobs = 2;
  networking.enableIntel3945ABGFirmware = true;
}
