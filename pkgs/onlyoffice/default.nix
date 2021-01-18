
{ stdenv, appimage-run, fetchurl, runtimeShell, libtasn1 }:

stdenv.mkDerivation rec {
  name = "onlyoffice${version}";
  version = "5.2.8";

  src = fetchurl {
    url = "http://download.onlyoffice.com/install/desktop/editors/linux/DesktopEditors-x86_64.AppImage";
    sha256 = "0rz3axvk5rqpmxs8cnjas1vpdj6b44abn2ir7724fnb1x5v26gx0";
  };

  nativeBuildInputs = [ libtasn1 ];
  buildInputs = [ appimage-run ];

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/{bin,share}
    cp $src $out/share/onlyoffice.AppImage
    echo "#!${runtimeShell}" > $out/bin/onlyoffice
    echo "${appimage-run}/bin/appimage-run $out/share/onlyoffice.AppImage" >> $out/bin/onlyoffice
    chmod +x $out/bin/onlyoffice $out/share/onlyoffice.AppImage
  '';

  meta = with stdenv.lib; {
    description = "office application";
    homepage = https://onlyoffice.com;
    license = licenses.agpl3;
    maintainers = with maintainers; [ mgregoire ];
    platforms = [ "x86_64-linux" ];
  };
}
