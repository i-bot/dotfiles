{ config, pkgs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./machines/hardware-configuration.nix
      ./neo.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.splashImage = null;

  environment.systemPackages = with pkgs; [
    # Programs for daily use.
    wget
    htop
    mysql
    python2
    python3
    openjdk
    firefox
    weechat
    rxvt_unicode
	
    # Tools required for file management.
    git
    stow
    
    # Tools for improving visual experience.
    feh
    xcompmgr
    redshift

    # Management of gtk-themes
    lxappearance
    
    # Packages required for xmonad.
    dmenu2
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
    
    # Packages needed for haskell programming
    haskellPackages.ghc
    haskellPackages.ghcMod
    haskellPackages.cabal2nix
    haskellPackages.hlint
    haskellPackages.hoogle
  ];
  
  programs.bash.enableCompletion = true;

  services.xserver.enable = true;

  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.displayManager.slim.theme = /etc/slim/nixos;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.rxvt_unicode}/bin/urxvtd -q -f -o			# urxvt terminal daemon
    ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr	# set left-pointer for xmonad
    ${pkgs.xcompmgr}/bin/xcompmgr &				# composite manager
    ${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper &		# custom wallpaper
  '';

  # Don't show the `Session: none + xmonad` message
  services.xserver.displayManager.slim.extraConfig = ''
    session_y 200%
  '';

  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;

  services.redshift.enable = true;
  services.redshift.latitude = "48.267852";
  services.redshift.longitude = "10.987011";

  users.extraGroups.i-bot = {};

  users.extraUsers.i-bot = {
    isNormalUser = true;
    createHome = true;
    home = "/home/i-bot";
    group = "i-bot";
    extraGroups = ["wheel" "networkManager"];
  };

  time.timeZone = "Europe/Berlin";
}
