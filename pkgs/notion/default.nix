{ stdenv, fetchurl, dpkg, autoPatchelfHook,
  glibc, glib, gcc-unwrapped, libnotify, nss, gtk3,
  libXScrnSaver, xorg, xdg_utils,
  at-spi2-core, libuuid, kde-cli-tools, 
  trash-cli, gvfs}:
let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "2.0.6";

  src = fetchurl {
    url = "https://github.com/davidbailey00/notion-deb-builder/releases/download/v${version}-windows/notion-desktop_${version}_amd64.deb";
    sha256 = "1bcsb4z9fh6rkvpn35n4f2m67h088438264spy86pd4xwdkg0fyq";
  };

  name = "Notion-${version}";

in stdenv.mkDerivation {
  
  inherit version src name;

  system = "x86_64-linux";

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
  ];

  # Required at running time
  buildInputs = [ glibc gcc-unwrapped glib
    libnotify nss gtk3 xorg.libXScrnSaver
    xorg.libXtst xdg_utils at-spi2-core
    libuuid kde-cli-tools trash-cli gvfs];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    cp $out/usr/* $out/
    rm -rf $out/usr
  '';

  meta = with stdenv.lib; {
    description = "Notion.so desktop app";
    homepage = https://www.notion.so;
    license = licenses.unfree;
    maintainers = with stdenv.lib.maintainers; [ Pacman99 ];
    platforms = [ "x86_64-linux" ];
  };
}
