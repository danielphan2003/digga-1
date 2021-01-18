{ config, pkgs, ... }:
{
  services.spotifyd = {
    enable = true;
    package = (pkgs.spotifyd.override {
      withMpris = true;
    });
    settings = {
      global = {
	username = "pachum99@gmail.com";
      	password = "pacman99";
      	device_name = "spotifyd@belowTheCoffeeTable";
      };
    };
  };
}
