{ config, pkgs, ... }:

{
  home.file.".config/gcalcli/gcalclirc".text = ''
    --client-id=639147014507-bgdcsldtv6du1a60jfosokl69chv645q.apps.googleusercontent.com
    --client-secret=qmPfdoCfJdxBbwOvx2z_AAxe
  '';
  
  home.packages = [ pkgs.gcalcli ];
}
