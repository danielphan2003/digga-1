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

  services.flatpak.enable = true;
  services.openntpd.enable = true;

  location.provider = "geoclue2";

  fonts.fontconfig.enable = true;
}
