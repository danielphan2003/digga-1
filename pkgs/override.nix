pkgs: final: prev:
with pkgs;
{ 
  inherit (pkgs) 
    spotify
    gnome-podcasts
    manix; # used by core profile
}
