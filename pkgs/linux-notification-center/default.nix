{ stdenv, lib, fetchurl, haskellPackages, autoPatchelfHook, 
gtk3, gobject-introspection, cairo, pango, stack,
pkg-config, dbus, libxml2 }:

let
  dbusService = fetchurl {
    url = "https://github.com/phuhl/linux_notification_center/raw/master/com.ph-uhl.deadd.notification.service.in";
    sha256 = "0jvmi1c98hm8x1x7kw9ws0nbf4y56yy44c3bqm6rjj4lrm89l83s";
  };
in

stdenv.mkDerivation rec {

  pname = "linux_notification_center";
  version = "1.7.2";

  src = fetchurl {
    url = "https://github.com/phuhl/linux_notification_center/releases/download/1.7.2/deadd-notification-center";
    sha256 = "13f15slkjiw2n5dnqj13dprhqm3nf1k11jqaqda379yhgygyp9zm";
  };

  dontUnpack = true;

  nativeBuildInputs = [ 
    autoPatchelfHook
    pkg-config
  ];

  buildInputs = [
    gtk3
    gobject-introspection
    libxml2
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/deadd-notification-center
    chmod +x $out/bin/deadd-notification-center

    mkdir -p $out/share/dbus-1/services
    sed "s|##PREFIX##|$out|g" ${dbusService} > $out/share/dbus-1/services/com.ph-uhl.deadd.notification.service 
  '';

  meta = {
    description = "Notification center";
    homepage = "https://github.com/phuhl/linux_notification_center";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.pacman99 ];
    platforms = lib.platforms.linux;
  };
}
