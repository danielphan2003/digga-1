{ config, pkgs, ... }:

{
  programs.pidgin = {
    enable = true;
    plugins = with pkgs; [ 
      purple-hangouts purple-discord 
      purple-slack telegram-purple 
    ];
  };
}
