{ config, pkgs, ... }:
{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return" = "exec alacritty";
      "super + p" = "exec rofi -show run";
      "super + n" = "exec exec networkmanager_dmenu";
  
      # volume and brightness
      "XF86MonBrightnessUp" = "xbacklight -inc 5";
      "XF86MonBrightnessDown" = "xbacklight -dec 5";
      # close and kill
      "super + {_,shift + }x" = "bspc node -{c,k}";
  
      # focus and move to desktop
      "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
  
      # focus last node/desktop
      "super + {Tab, grave}" = "bspc {node,desktop} -f last";
  
      # control type of window(mod+f - fullscreen)
      "super + {t, shift + t,s,}" = "bspc node -t {tiled, pseudo_tiled,floating}";
  
      # fullscreen toggle
      "super + f" = "bspc node -t '~fullscreen'";
      
      # Hidden window, cool scratchpad
      "super + y" = "bspc node -g hidden";
      "super + u" = "show_hidden_windows";
      "super + shift + u" = "show_hidden_windows -q";
  
      # switch node with biggest node
      "super + g" = "bspc node -s biggest";

  
      # focus/swap the node in the given direction
      "super + {_, shift + }{h,j,k,l}" = "bspc node -{f,s} {west,south,north,east}";
  
      # focus the next/prev node
      "super + {_, shift + }c" = "bspc node -f {next,prev}.local";
  
      # expand window 
      "super + alt + {h,j,k,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
  
      # contract window
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
  
      # quit/restart bspwm
      "super + shift + {q,r}" = "bspc {quit, wm -r}";
    };
  };
} 
