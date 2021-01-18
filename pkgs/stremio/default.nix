{ fetchurl, fetchgit, which, qt5, ffmpeg, mpv, nodejs, 
  openssl, librsvg}:

let
  serverJS = fetchurl {
    url = "https://s3-eu-west-1.amazonaws.com/stremio-artifacts/four/master/server.js";
    sha256 = "0sdibl3v6xdvbssxx9qrm5x6yd8afb2az2zmsbcgdhg9gmlb8pcg";
  };
in qt5.mkDerivation rec {
  name = "stremio";
  version = "4.4.106";

  nativeBuildInputs = [ which ];
  buildInputs = [
    ffmpeg
    mpv
    nodejs
    openssl
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtquickcontrols
    qt5.qtquickcontrols2
    qt5.qttools
    qt5.qttranslations
    qt5.qtwebchannel
    qt5.qtwebengine
    librsvg
  ];

  dontWrapQtApps = true;
  preFixup = ''
    wrapQtApp "$out/opt/stremio/stremio" --prefix PATH : "$out/opt/stremio"
  '';

  src = fetchgit {
    url = "https://github.com/Stremio/stremio-shell";
    rev = version;
    sha256 = "05lp1iq08n8wh7m12d9pz9lg6hwc0d936kmlzvdxwxbnm86cxy54";
    fetchSubmodules = true;
  };

  buildPhase = ''
    cp ${serverJS} server.js
    make -f release.makefile PREFIX="$out/"
  '';

  installPhase = ''
    make -f release.makefile install PREFIX="$out/"
    mkdir -p "$out/bin"
    ln -s "$out/opt/stremio/stremio" "$out/bin/stremio"
  '';
}
