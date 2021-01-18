{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    mercurial
    gnumake
    tmux
    zip
    nmap
    rclone
    wmctrl
    imagemagick
    playerctl
    appimage-run
    usbutils
    nix-review
    ddgr
    xclip
  ];

}
