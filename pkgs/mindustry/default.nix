{ lib, stdenv, fetchurl, makeDesktopItem, libpulseaudio, makeWrapper, jdk, jre }:

let
  desktopItem = makeDesktopItem {
    name = "mindustry";
    exec = "mindustry";
    icon = "mindustry";
    comment = "A sandbox tower defense game";
    desktopName = "Mindustry";
    genericName = "mindustry";
    categories = "Game;";
  };

in stdenv.mkDerivation rec {
  name = "Mindustry-${version}";
  version = "v107";

  src = fetchurl {
    url = "https://github.com/Anuken/Mindustry/releases/download/${version}/Mindustry.jar";
    sha256 = "0xv5fg333ccf3xbr75vx5fca0cgl538sz94pmkc9xdnvy1f4i94h";
  };

  nativeBuildInputs = [ makeWrapper ];

  unpackPhase = "${jdk}/bin/jar xf $src icons/icon_64.png";

  installPhase = ''
    mkdir -p $out/bin $out/share/mindustry

    makeWrapper ${jre}/bin/java $out/bin/mindustry \
      --add-flags "-jar $out/share/mindustry/mindustry.jar" \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libpulseaudio ]}

    cp $src $out/share/mindustry/mindustry.jar
    cp -r ${desktopItem}/share/applications $out/share
    install -D icons/icon_64.png $out/share/icons/hicolor/32x32/apps/mindustry.png
  '';

  meta = with lib; {
    description = "A sandbox tower defense game";
    homepage = https://mindustrygame.github.io/;
    maintainers = with maintainers; [ pacman99 ];
    license = licenses.gpl3;
  };
}
