final: prev: {
  heroic-launcher = prev.callPackage ./heroic { };
  mindustry = prev.callPackage ./mindustry { };
  deadd-notification-center = prev.callPackage ./deadd-notification-center { };
  cups-pdf = prev.callPackage ./cups-pdf { };
  brlaser = prev.callPackage ./brlaser { };
  giara = prev.callPackage ./giara { };
  spacevim = prev.callPackage ./spacevim { };
  notorious = prev.callPackage ./notorious { };
  ripcord = prev.qt5.callPackage ./ripcord { };
  # fractal = prev.callPackage ./fractal-unstable { };
}
