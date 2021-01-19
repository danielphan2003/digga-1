enabledProfiles: let
  profileImports = map (name: import (./. + "/../profiles/${name}.nix")) enabledProfiles;
in { config, pkgs, lib, ... }: {

  users.users.pachums = {
    hashedPassword = lib.fileContents ../../secrets/userPass;
    isNormalUser = true;
    extraGroups = [ "vboxusers" "scanner" "wheel" "networkmanager" "input" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    home = "/home/pachums";
  };

  home-manager.users.pachums = { ... }: {
    imports = lib.lists.flatten profileImports;
    programs.home-manager.enable = true;
    home.stateVersion = config.system.stateVersion;
  };

}

