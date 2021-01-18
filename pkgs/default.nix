final: prev: { 
  heroic-launcher = prev.callPackage ./heroic { };
  mindustry = prev.callPackage ./mindustry { };
  deadd-notification-center = prev.callPackage ./linux-notification-center { };
  cups-pdf = prev.callPackage ./cups-pdf { };
  brlaser = prev.callPackage ./brlaser { };
  leonflix = prev.callPackage ./leonflix { };
}
