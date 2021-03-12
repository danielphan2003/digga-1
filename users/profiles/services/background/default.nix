{ config, pkgs, ... }:
let
  bgFolder = pkgs.stdenv.mkDerivation {
    name = "libraryBackgroundFolder";
    src = pkgs.fetchurl {
      url = "https://www.dementiajourney.org/wp-content/uploads/2017/10/desktop-wallpaper-books-wallpapers-bookshelf-old-ladder-book-library-vintage-cartoon.jpg";
      sha256 = "0ip2ps5ilciib525qvsmkmd2pcg9zcwkfmgnpw972nwh2zf1ypad";    
    };
    buildCommand = ''
      ln -s $src $out
    '';
  };

in 
{
  
  services.random-background = {
    enable = true;
    imageDirectory = "${bgFolder}";
  };
  
}
