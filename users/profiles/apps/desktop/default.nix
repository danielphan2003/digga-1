{ config, pkgs, ... }:

{
    
  programs.feh.enable = true;

  home.packages = with pkgs; [
    system-config-printer
    pavucontrol
    xorg.xev
    flameshot

    # linux-notification-center

    arandr
    xorg.xbacklight
    simplescreenrecorder
    
    (writeShellScriptBin "rotate" (builtins.readFile ../custompkgs/rotate))

    wineFull

    xtitle
    (writeShellScriptBin "show_hidden_windows" ''
      nodes=( $(bspc query -N -n .hidden) ) && s=$(xtitle ''${nodes[@]} | rofi -dmenu -format i)
      node=''${nodes[$s]}
      [[ -n "$s" ]] && bspc node $node -n focused -g hidden=off -f
      # [[ -n $1 ]] && bspc subscribe node_focus -c 1 && bspc node $node -g hidden=on
    '')

    
  ];

}
