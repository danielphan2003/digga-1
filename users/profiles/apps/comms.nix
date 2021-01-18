{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    jitsi-meet
    zoom-us
    thunderbird
    slack
    ripcord
    (discord.overrideAttrs (super: rec {
      version = "0.0.13";
      src = fetchurl {
        url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
        sha256 = "0d5z6cbj9dg3hjw84pyg75f8dwdvi2mqxb9ic8dfqzk064ssiv7y";
      };
    }))
    signal-desktop
    element-desktop
    fractal
    # nheko
  ];

}
