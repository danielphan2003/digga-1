{ config, pkgs, lib, ... }:

{
  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.nordic;
  #     name = "Nordic";
  #   };
  # };
  qt.platformTheme = "gtk";

  # Lets you add fonts to home.packages
  # Auto updates font cache
  fonts.fontconfig.enable = lib.mkForce true;

  # Fonts and Icons
  home.packages = with pkgs; [
    wineWowPackages.fonts
    iosevka
    font-awesome-ttf
    siji
    noto-fonts
    corefonts
    gnome2.gnome_icon_theme
    hicolor-icon-theme
  ];

}
