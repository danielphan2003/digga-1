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
}
