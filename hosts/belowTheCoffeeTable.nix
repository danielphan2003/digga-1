{ modulesPath, lib, config, pkgs, ... }:
let
  enabledProfiles = [
    "bluetooth"
    "develop"
    "efi-grub"
    "gnome"
    "graphical"
    "printing"
    "sound"
    "xorg"
    "usb"
    "nix-builder"
  ];
in {

  imports = [ # Include the results of the hardware scan.
    "${modulesPath}/installer/scan/not-detected.nix"
    (import ../users/pachums ["clifull" "apps"])
    ../users/root
    ../profiles/develop.nix
  ] ++ (map (x: import (./. + "/../profiles/${x}.nix")) enabledProfiles);

  users.mutableUsers = false;

  services.xserver.videoDrivers = [ "intel" ];

  # wifi config
  networking.hostName = "belowTheCoffeeTable"; # Define your hostname.
  networking.networkmanager.enable = true;

  ## Hardware
  hardware = {
    cpu.intel.updateMicrocode = true;
    # broken sensor.iio.enable = true;
  };

  ## BootLoader configuration
  boot.loader.grub = {
    configurationLimit = 4;
    efiInstallAsRemovable = true;
    efiSupport = true;
    devices = [ "nodev" ];
  };

  system.stateVersion = "20.09";

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6d795dbd-db0a-4852-a05e-d292bddb492e";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/sda1";
      fsType = "vfat";
    };
    "/home/pachums" = {
      device = "/dev/sda2";
      fsType = "ext4";
    };
  };

  swapDevices = [ { device="/dev/sda6"; } ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

