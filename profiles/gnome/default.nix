{ pkgs, ... }:
{
  services.xserver = {
    displayManager.gdm = {
      enable = true;
    };

    desktopManager.gnome3.enable = true;

    layout = "us";
    enable = true;

  };

  xdg.portal.enable = true;

  services.dbus.packages = [ pkgs.gnome3.dconf ];

  environment.systemPackages = with pkgs; [
    libsecret
  ];

}
