{ pkgs, ... }:
{
  hardware.opengl = {
    setLdLibraryPath = true;
    enable = true;
    driSupport32Bit = true;
    extraPackages = [
      pkgs.libGL_driver
    ];
  };
  environment.systemPackages = [ pkgs.virtualgl ];

  systemd.packages = [ pkgs.deadd-notification-center ];

  services.flatpak.enable = true;
}
