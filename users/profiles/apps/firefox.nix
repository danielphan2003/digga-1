{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg.drmSupport = true;
    };
  };

  # Side bitches
  home.packages = with pkgs; [
    # vieb
    # qutebrowser
    # brave
  ];

}
