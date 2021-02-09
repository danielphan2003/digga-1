{ pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    fsIdentifier = "uuid";
    splashImage = pkgs.fetchurl {
      url = "https://www.dementiajourney.org/wp-content/uploads/2017/10/desktop-wallpaper-books-wallpapers-bookshelf-old-ladder-book-library-vintage-cartoon.jpg";
      sha256 = "0ip2ps5ilciib525qvsmkmd2pcg9zcwkfmgnpw972nwh2zf1ypad";
    };
  };
}
    

