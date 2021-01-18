{ config, pkgs, ... }:

let
  my-python-packages = python-packages: with python-packages; [
      jedi
      pylint
      pynvim
      pip
      # other python packages you want
    ];
    python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in

{
  imports = [ # Include the results of the hardware scan.
    ./belowTheCoffeeTable-hardware.nix
    (import ../users/pachums ["clifull" "apps"])
    ../users/root
  ];

  users.mutableUsers = false;

  ## List of System Packages
  environment.systemPackages = with pkgs; [
    libsecret
    aspellDicts.en
    aspell
    frei0r
    cdrkit
    gradle
    gparted
    unrar
    gnupg
    virtualgl
    google-chrome
    universal-ctags
    ctagsWrapped.ctagsWrapped
    python-with-my-packages
    appimage-run
    nodejs
    yarn
    wget 
    unzip
    atool
    git
    nix-prefetch-github
    unetbootin
    ntfs3g
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  ## Program setup
  programs = {
    java.enable = true;
    zsh.enable = true;
    vim.defaultEditor = true;
    adb.enable = true;
    # plotinus.enable = true;
  };
  
  virtualisation = {
    # virtualbox.host = {
    #   enable = true;
    #   enableExtensionPack = true;
    # };
  };

  fonts.fontconfig.enable = true;


  ## Enabled Services
  services = {

    # postgresql.enable = true;

    openntpd.enable = true;

    blueman.enable = true;
    
    flatpak.enable = true;

    # tlp.enable = true;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      cups-pdf = {
	enable = true;
      };
      drivers = with pkgs; [ hplipWithPlugin brlaser brgenml1lpr brgenml1cupswrapper ];
    };

    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # X11 windowing system.
    xserver = {
      enable = true;
      layout = "us";
      # xkbOptions = "eurosign:e";
      videoDrivers = [ "intel" ];

      # Enable touchpad support.
      libinput.enable = false;
      synaptics = {
        enable = true;
        accelFactor = "0.45";
        maxSpeed = "1.9";
        minSpeed = ".7";
        twoFingerScroll = true;
        horizTwoFingerScroll = true;
      };

      displayManager.gdm = {
	enable = true;
	wayland = false;
      };
      # displayManager.sddm.enable = true;
      
      # desktopManager.xterm.enable = true;
      desktopManager.gnome3.enable = true;
    
    };

    dbus.packages = with pkgs; [ gnome3.dconf ];

  };

  xdg.portal.enable = true;


  # wifi config
  networking = {
    hostName = "belowTheCoffeeTable"; # Define your hostname.
    firewall.enable = false;
    networkmanager = {
      enable = true;
      extraConfig = ''
        [main]
        rc-manager=resolvconf
      '';

    };
  };

  # Enable sound.
  sound.enable = true;


  ## Hardware
  hardware = {

    cpu.intel.updateMicrocode = true;

    sensor.iio.enable = true;
    
    bluetooth.enable = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };

    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };


    ## Display configuration
    opengl = {
      setLdLibraryPath = true;
      enable = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.libGL_driver
      ];
    };
  
  };

  security.pam.services.pachums.fprintAuth = true;


  ## BootLoader configuration 
  boot.loader.grub = {
    enable = true;
    configurationLimit = 4;
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
    fsIdentifier = "uuid";
    splashImage = pkgs.fetchurl {
      url = "https://www.dementiajourney.org/wp-content/uploads/2017/10/desktop-wallpaper-books-wallpapers-bookshelf-old-ladder-book-library-vintage-cartoon.jpg";
      sha256 = "0ip2ps5ilciib525qvsmkmd2pcg9zcwkfmgnpw972nwh2zf1ypad";
    };
    
    devices = [ "nodev" ];
  };

  boot.supportedFilesystems = [ "exfat" ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  console = {
    keyMap = "us";
    font = "Lat2-Terminus15";
  };

 location.provider = "geoclue2";

  system.stateVersion = "20.09";

}
