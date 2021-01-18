{ stdenv
, fetchurl
, autoPatchelfHook 
, makeWrapper
}:

stdenv.mkDerivation rec {
  name = "ventoy";
  version = "1.0.12";

  src = fetchurl {
    url = "https://github.com/ventoy/Ventoy/releases/download/v${version}/ventoy-${version}-linux.tar.gz";
    sha256 = "0ibg92i5yzxph2z9wdf9mcd5l1713f7r7ibh766pl8ijkfwvcmii";
  };

  nativeBuildInputs = [ 
    autoPatchelfHook 
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/ventoy

    install -Dm644 boot/* -t $out/opt/ventoy/boot/
    install -Dm644 ventoy/* -t $out/opt/ventoy/ventoy/
    install -Dm755 tool/* -t $out/opt/ventoy/tool/
    install -Dm755 Ventoy2Disk.sh -t $out/opt/ventoy/

    makeWrapper $out/opt/ventoy/Ventoy2Disk.sh $out/bin/ventoy
  '';

  meta = with stdenv.lib; {
    description = "An open source tool to create bootable USB drive for ISO files";
    homepage = "https://ventoy.net";
    license = licenses.gpl3;
    maintainers = with maintainers; [ filalex77 ];
    platforms = platforms.linux;
  };
}
