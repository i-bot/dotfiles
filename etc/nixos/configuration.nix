{ config, pkgs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./machines/current-machine.nix
      ./neo.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  nix.trustedBinaryCaches = [
    "http://hydra.nixos.org"
    "http://hydra.cryp.to"
  ];

  environment.systemPackages = with pkgs; [
    # daily use
    wget
    htop
    python2
    python3
    openjdk
    firefox
    thunderbird
    rxvt_unicode
    tmux
    emacs

    # LaTeX
    texLiveFull
    zathura

    # communication
    weechat
    pond
    mutt-with-sidebar
    isync
    msmtp
    gnupg
    gpgme
    pass
	
    # file management
    git
    stow
    
    # visual things
    feh
    xcompmgr
    redshift
    lxappearance
    libnotify
    
    # xmonad
    dmenu
    haskellngPackages.xmobar
    haskellngPackages.xmonad
    haskellngPackages.xmonad-contrib
    haskellngPackages.xmonad-extras
    alock
    acpi

    # haskell programming
    haskellngPackages.ghc
    haskellngPackages.ghc-mod
    haskellngPackages.cabal2nix
    haskellngPackages.hlint
    haskellngPackages.hoogle
    haskellngPackages.hdevtools
  ];
  
  programs.bash.enableCompletion = true;

  services.xserver.enable = true;
  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.displayManager.slim.theme = /etc/slim/nixos;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.rxvt_unicode}/bin/urxvtd -q -f -o			# urxvt daemon
    ${pkgs.xlibs.xsetroot}/bin/xsetroot -cursor_name left_ptr	# set left-pointer for xmonad
    ${pkgs.xcompmgr}/bin/xcompmgr &				# composite manager
    ${pkgs.feh}/bin/feh --bg-fill ~/.wallpaper &		# custom wallpaper
    ${pkgs.emacs}/bin/emacs --daemon &
  '';

  # Don't show the `Session: none + xmonad` message
  services.xserver.displayManager.slim.extraConfig = ''
    session_y 200%
  '';

  services.xserver.startGnuPGAgent = true;

  # Enable and Configure redshift
  services.redshift.enable = true;
  services.redshift.latitude = "48.267852";
  services.redshift.longitude = "10.987011";
  services.redshift.temperature.night = 4000;

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
