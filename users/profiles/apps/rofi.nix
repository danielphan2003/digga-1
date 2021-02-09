{ config, pkgs, ... }:

{

  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-soft";
    package = pkgs.rofi.override {
      plugins = with pkgs; [
        rofi-emoji
        rofi-calc
        rofi-blocks
      ];
    };
  };

}

