{ lib
, fetchFromGitLab
, meson
, gobject-introspection
, pkg-config
, ninja
, python3
, wrapGAppsHook
, gtk3
, gdk-pixbuf
, webkitgtk
, gtksourceview4
, libhandy
, glib-networking
}:

python3.pkgs.buildPythonApplication rec {
  pname = "notorious";
  version = "2021-01-21";

  format = "other";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "GabMus";
    repo = pname;
    rev = "1cf87511d7e4a04e6024701038ecec668e71edfe";
    sha256 = "0d9yf2nb5payfbx95c631cik7jx662pqh9l93jdmp375mhghr9m8";
  };

  nativeBuildInputs = [
    meson
    gobject-introspection
    pkg-config
    ninja
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    gtksourceview4
    libhandy
  ];

  pythonPath = with python3.pkgs; [
    pygobject3
  ];

  # Fix setup-hooks https://github.com/NixOS/nixpkgs/issues/56943
  strictDeps = false;

  meta = with lib; {
    description = "Keyboard centric notes";
    maintainers = with maintainers; [ pacman99 ];
    homepage = "https://gitlab.gnome.org/GabMus/notorious";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
