{ config, pkgs, ... }:

{
   
  xsession.windowManager.bspwm.startupPrograms = [ "${pkgs.volnoti}/bin/volnoti" ];

  home.packages = [
    (pkgs. writeShellScriptBin "vol" ''
      if [[ $cvol < 150 ]];then
          pactl set-sink-volume @DEFAULT_SINK@ $1
      fi
      cvol=`pactl list sinks | sed -nE 's/Volume:\sfront-left:.*\s+([0-9]+)%\s.*/\1/p'`
      if [ $cvol == 0 ]; then
      	cvol='--mute'
      fi
      ${pkgs.volnoti}/bin/volnoti-show $cvol > /dev/null
    '')
  ];

  services.sxhkd.keybindings = {
    "XF86AudioRaiseVolume" = "exec vol +5%";
    "XF86AudioLowerVolume" = "exec vol -5%";
  };
  

}

