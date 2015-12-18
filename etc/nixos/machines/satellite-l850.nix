{ config, lib, pkgs, ... }:

{
  boot.loader.grub.extraEntries =
    "menuentry \"Windows 10\" {
      chainloader (hd0,1)+1
    }";

  nixpkgs.config.allowUnfree = true;
  services.xserver.videoDrivers = [ "ati-unfree" ];
  services.xserver.synaptics.enable = true;
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xlibs.xrandr}/bin/xrandr --output LVDS-0 --auto --pos -2x312  --output HDMI-0 --auto --primary --pos 1366x0
  '';

  networking.hostName = "satellite-l850";
  networking.hostId = "e15c1e1c";
  networking.networkmanager.enable = true;

  hardware.opengl.driSupport32Bit = true;
}
