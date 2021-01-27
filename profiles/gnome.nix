{ pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm = {
      enable = true;
    };

    desktopManager.gnome3.enable = true;

  };

  services.dbus.packages = [ pkgs.gnome3.dconf ];

  environment.systemPackages = with pkgs; [
    libsecret
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
