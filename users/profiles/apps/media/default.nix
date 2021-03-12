{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    giara
    # gnome-podcasts
    spotify-tui
    spotify
    gimp
    vlc
    gnome3.cheese
    gnome3.eog
    peek
    krita
    inkscape
    newsflash
    lollypop
    shortwave
    ncspot
    (kodi.override {
      plugins = with pkgs.kodiPlugins; [
        pvr-hts
      ];
    })
    # stremio
  ];

}
