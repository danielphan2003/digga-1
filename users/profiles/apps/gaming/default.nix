{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris
    steam
    samba
    # zeroad
    multimc
    lutris
    mindustry
    (writeShellScriptBin "Mindustry" ''
      ${pkgs.steam}/bin/steam steam://rungameid/1127400
    '')
  ];
}

