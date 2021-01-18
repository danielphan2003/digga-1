{ stdenv, lib, fetchurl, makeWrapper, at-spi2-atk, at-spi2-core, fontconfig, cairo, 
    gdk-pixbuf, gtk2-x11, atk, dbus, pango, gobject-introspection, freetype,
    ffmpeg, systemd, nss, alsaLib, nspr, gnome2, glib, glibc, expat, cups, xorg }:

stdenv.mkDerivation rec {
  name = "turtl-${version}";
  version = "0.7.2.5";

  src = fetchurl {
    url = "https://github.com/turtl/desktop/releases/download/v${version}/turtl-${version}-linux64.tar.bz2";
    sha256 = "10df6ifldpq8j66s016mb2cdd2fvix510grfbdxx1k1yg32b4s1w";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  
  installPhase = ''
    mkdir -p $out/bin $out/share

    cp -r turtl $out/share/

    ln -s $out/share/turtl/turtl $out/bin/turtl
    
  '';

  postFixup = let
    deps = [
      fontconfig
      ffmpeg
      cairo
      alsaLib
      gtk2-x11
      gdk-pixbuf
      at-spi2-atk
      at-spi2-core
      atk
      dbus
      pango
      gobject-introspection
      freetype
      gnome2.GConf
      glib
      glibc
      cups
      nss
      nspr
      expat
      xorg.libXScrnSaver
      xorg.libXfixes
      xorg.libXrender
      xorg.libXi
      xorg.xcbutil
      xorg.libxcb
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXrandr
      xorg.libXcomposite
      xorg.libXext
      xorg.libX11
      xorg.libXtst
      stdenv.cc.cc
      stdenv.cc.cc.lib
    ];
    libPathNative = lib.makeLibraryPath deps;
    libPath64 = lib.makeSearchPathOutput "lib" "lib64" deps;
    libPath = "${libPathNative}:${libPath64}";
  in ''
    patchelf \
	--set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
	--set-rpath "${libPath}:$out/share/turtl" \
	$out/share/turtl/turtl 

    patchelf \
	--set-rpath "${libPath}:$out/share/turtl" \
	$out/share/turtl/libnode.so 

    chmod a+x $out/share/turtl/libffmpeg.so

    ln -s ${systemd.lib}/lib/libudev.so.1 $out/share/turtl/libudev.so.1

    wrapProgram $out/share/turtl/turtl \
      --prefix LD_LIBRARY_PATH : $out/share/turtl

   '';
	
  meta = with stdenv.lib; {
    description = "Crossplatform tool for fast makinkadjsfdsg screenshots";
    homepage = https://github.com/lxqt/screengrabksdjf;
    maintainers = with maintainers; [ pacman99 ];
    license = licenses.gpl2;
  };
}
