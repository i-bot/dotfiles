{ config, pkgs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./machines/hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.splashImage = null;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "de";
  };

  environment.systemPackages = with pkgs; [
    wget
    htop
    git
    rxvt_unicode
    python2
    python3
    stow
	
    xcompmgr
    feh

    dmenu
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
    weechat

    haskellPackages.ghc
    haskellPackages.cabal2nix
    haskellPackages.hlint
    haskellPackages.hoogle

    firefox
    gtk-engine-murrine
    lxappearance
    xlibs.xmessage
  ];
  
  programs.bash.enableCompletion = true;

  services.xserver.enable = true;
  services.xserver.layout = "de";
  services.xserver.xkbVariant = "neo";

  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  services.xserver.windowManager.default = "xmonad";
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.displayManager.slim.theme = /etc/slim/nixos;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.rxvt_unicode}/bin/urxvtd -q -f -o
    ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr
    ${pkgs.xcompmgr}/bin/xcompmgr &
    ${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper &
  '';

  # Don't show the `Session: none + xmonad` message
  services.xserver.displayManager.slim.extraConfig = ''
    session_y 200%
  '';

  users.extraGroups.i-bot = {};

  users.extraUsers.i-bot = {
    isNormalUser = true;
    createHome = true;
    home = "/home/i-bot";
    group = "i-bot";
    extraGroups = ["wheel"];
  };

  time.timeZone = "Europe/Berlin";
}
