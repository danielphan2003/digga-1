{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    notorious
    standardnotes
    gnome3.gnome-notes
    rclone-browser
    libreoffice
    gnome3.simple-scan
    calibre
    (writeShellScriptBin "acroreadc" ''
      env WINEPREFIX="/home/pachums/.wine" wine "C:\Program Files\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe"
    '')
    hunspell
    hunspellDicts.en-us-large
    wineWowPackages.full
  ];

}
