{ config, pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: 
      with exts; [ pass-otp pass-import ]);
  };
  
  home.file.".config/rofi-pass/config".text = ''
    default_user = ":filename"
  '';
  
  home.packages = [ pkgs.rofi-pass ];
}
