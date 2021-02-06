{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    universal-ctags
    ctagsWrapped.ctagsWrapped
    nix-prefetch-scripts
    nixpkgs-review
    nixpkgs-fmt
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
