{ config, pkgs, lib, ... }:
{
  users.users.pachums = {
    hashedPassword = lib.fileContents ../../secrets/userPass;
    isNormalUser = true;
    extraGroups = [ "vboxusers" "scanner" "wheel" "networkmanager" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    home = "/home/pachums";
  };

  home-manager.users.pachums = {
    programs.home-manager.enable = true;
    home.stateVersion = config.system.stateVersion;
  };

}

