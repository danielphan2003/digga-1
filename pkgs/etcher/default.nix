{ appimageTools, fetchurl, lib, gsettings-desktop-schemas, gtk3 }:

let
  pname = "balena-etcher-electron";
  version = "1.5.50";
in
appimageTools.wrapType2 rec {
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://github.com/balena-io/etcher/releases/download/v1.5.50/balenaEtcher-1.5.50-x64.AppImage";
    sha256 = "0bhjzl5m3xgcaldk7xz9znkl0pjsnnqkw1wmf1pz24m4p70plx6k";
  };

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  multiPkgs = null; # no 32bit needed
  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  extraInstallCommands = "mv $out/bin/{${name},${pname}}";

  # meta = with lib; {
  #   description = "Flash OS images to SD cards & USB drives, safely and easily.";
  #   homepage = https://www.balena.io/etcher/;
  #   license = licenses.asl20;
  #   # Should be cross-platform, but for now we just grab the appimage
  #   platforms = [ "x86_64-linux" ];
  #   maintainers = with maintainers; [ pacman99 ];
  # };
}
