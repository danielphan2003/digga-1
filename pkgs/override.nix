pkgs: final: prev:
with pkgs;
{ 
  inherit (pkgs) 
    spotify
    gnome-podcasts
    gnome-notes
    manix; # used by core profile
}
