{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    zoom-us
    ripcord
    discord
    element-desktop
    # fractal
    # nheko
  ];

}
