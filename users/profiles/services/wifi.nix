{ config, pkgs, ... }:

{
  home.file.".config/networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = ${pkgs.rofi}/bin/rofi
  '';

  services.network-manager-applet.enable = true;
  
  home.packages = [ 
    networkmanager_dmenu 
  ];

}
