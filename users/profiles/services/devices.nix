{ config, ... }:

{

  services.blueman-applet.enable = true;

  services.udiskie = {
    enable = true;
  };

}
