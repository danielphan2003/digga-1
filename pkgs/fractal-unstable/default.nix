{ lib
, stdenv
, fetchFromGitLab
, nix-update-script
, fetchpatch
, meson
, ninja
, gettext
, cargo
, cmake
, rustc
, python3
, rustPlatform
, pkg-config
, gtksourceview4
, glib
, libhandy
, gtk3
, dbus
, openssl
, sqlite
, gst_all_1
, cairo
, gdk-pixbuf
, gspell
, wrapGAppsHook
}:

rustPlatform.buildRustPackage rec {
  pname = "fractal";
  version = "2021-01-22";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "GNOME";
    repo = "fractal";
    rev = "b056f25f1beb548b359afb8f62f9f5a0883c002d";
    sha256 = "LUDt15z13I0jZnJM5g+B7xsK8vKzDZQGf9foSz2CZks=";
  };

  cargoSha256 = "WDEXJeMD+Wr0MZ3txG5iaJz6b+C9o1UhjUV35iHHQhA=";

  nativeBuildInputs = [
    cargo
    gettext
    meson
    ninja
    pkg-config
    python3
    rustc
    wrapGAppsHook
    glib
  ];

  buildInputs = [
    cmake
    cairo
    dbus
    gdk-pixbuf
    glib
    gspell
    gst_all_1.gst-editing-services
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    (gst_all_1.gst-plugins-good.override {
      gtkSupport = true;
    })
    gst_all_1.gstreamer
    gst_all_1.gst-devtools
    gtk3
    gtksourceview4
    libhandy
    openssl
    sqlite
  ];

  postPatch = ''
    chmod +x scripts/test.sh
    patchShebangs scripts/meson_post_install.py scripts/test.sh
  '';

  # Don't use buildRustPackage phases, only use it for rust deps setup
  configurePhase = null;
  buildPhase = null;
  checkPhase = null;
  installPhase = null;

  passthru = {
    updateScript = nix-update-script {
      attrPath = pname;
    };
  };

  meta = with lib; {
    description = "Matrix group messaging app";
    homepage = "https://gitlab.gnome.org/GNOME/fractal";
    license = licenses.gpl3;
    broken = stdenv.isDarwin;
    maintainers = with maintainers; [ dtzWill worldofpeace ];
  };
}
