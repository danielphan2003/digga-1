{ appimageTools, fetchurl, lib, gsettings-desktop-schemas, gtk3 }:
let
  pname = "pulse-sms";
  version = "4.1.0";
  name = "${pname}-${version}";
in appimageTools.wrapType2 rec {
  inherit name;
  src = fetchurl {
    url = "https://github.com/flavioislima/HeroicGamesLauncher/releases/download/v${version}/heroic-${version}.AppImage";
    sha256 = "0f5qj0910iwgab3mawap9l2gqca1xdpy88nrrvcnili612yrxwh0";
  };

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  multiPkgs = null; # no 32bit needed
  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  extraInstallCommands = "mv $out/bin/{${name},${pname}}";

  meta = with lib; {
    description = "Desktop sms for pulsesms.app";
    homepage = https://messenger.klinkerapps.com/overview/platform-linux.html;
    license = licenses.asl20;
    # Should be cross-platform, but for now we just grab the appimage
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ pacman99 ];
  };
}
