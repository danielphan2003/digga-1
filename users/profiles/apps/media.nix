{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome-podcasts
    spotify-tui
    spotify
    gimp
    vlc
    leonflix
    gnome3.cheese
    gnome3.eog
    krita
    inkscape
    newsflash
    lollypop
    shortwave
    ncspot
    (kodi.override {
      plugins = with pkgs.kodiPlugins; [
        advanced-launcher
        pvr-hts
      ];
    })
    # stremio
  ];

}
