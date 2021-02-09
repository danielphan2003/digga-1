{
  environment.systemPackages = with pkgs; [
    plotinus
  ];
  ## Plotinus config
  /* existing conflicts with gnome module
     setting XDG_DATA_DIRS for mimeapps */
  environment.sessionVariables.XDG_DATA_DIRS =
    [ "${pkgs.plotinus}/share/gsettings-schemas/${pkgs.plotinus.name}" ];
  environment.variables.GTK3_MODULES =
    [ "${pkgs.plotinus}/lib/libplotinus.so"];

  }
