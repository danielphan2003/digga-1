{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    cups-pdf = {
      enable = true;
    };
    drivers = with pkgs; [ hplipWithPlugin brlaser brgenml1lpr brgenml1cupswrapper ];
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };

}


