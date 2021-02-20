{ ... }:
{
# X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    # xkbOptions = "eurosign:e";

    displayManager.gdm.wayland = false;

    # Enable touchpad support.
    libinput.enable = false;
    synaptics = {
      enable = true;
      accelFactor = "0.45";
      maxSpeed = "1.9";
      minSpeed = ".7";
      twoFingerScroll = true;
      horizTwoFingerScroll = true;
    };
  };

  xdg.portal.enable = true;
}

