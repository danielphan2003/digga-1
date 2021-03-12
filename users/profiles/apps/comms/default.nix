{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    zoom-us
    ripcord
    element-desktop
    # fractal
    # nheko
  ];

}
