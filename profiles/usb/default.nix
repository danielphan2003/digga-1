{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ntfs3g
  ];

  boot.supportedFilesystems = [ "exfat" ];
}



