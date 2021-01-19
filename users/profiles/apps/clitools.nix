{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    universal-ctags
    ctagsWrapped.ctagsWrapped
    nix-prefetch-github
    gradle
    unrar
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
