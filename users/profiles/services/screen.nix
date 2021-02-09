{ config, pkgs, ... }:

{
  services.picom = {
    enable = true;
    inactiveOpacity = ".76";
  };

  services.redshift = {
    enable = true;
    temperature = {
      day = 3000;
      night = 1500;
    };
    provider = "geoclue2";
    tray = true;
  };
}
