{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # gnomeExtensions.paperwm
    gnome3.gnome-tweaks
    gnome3.dconf-editor
  ];
}
