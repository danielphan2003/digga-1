{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    atop
    wget
    unzip
    git
    atool
    unrar
    gnupg
    pstree
    git-crypt
  ];

  programs.gpg = {
    enable = true;
  };

}
