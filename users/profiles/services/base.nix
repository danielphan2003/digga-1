{ config, pkgs, ... }:
{
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = { "eDP1" = ["I" "II" "I1I" "IV" "V" "VI" "VII" "VIII" "IX" "X" ]; };
    settings = {
      "window_gap" = "15";
    };
  };

  xsession.enable = true;

  xsession.pointerCursor = {
    name = "Numix-Cursor";
    package = pkgs.numix-cursor-theme;
  };


}
