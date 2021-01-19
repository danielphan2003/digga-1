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
  ];

}
