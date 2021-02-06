final: prev: {
  # ripcord = prev.ripcord.override (old: rec {
  #   version = "0.4.28";

  #   src = let
  #     appimage = fetchurl {
  #       url = "https://cancel.fm/dl/Ripcord-${version}-x86_64.AppImage";
  #       sha256 = "0bczqp4kny7jlp06f4bh1xg0x17g8980dj6pk4waqc7qk88i6sfv";
  #       name = "${old.pname}-${version}.AppImage";
  #     };
  #   in appimageTools.extract {
  #     name = "${old.pname}-${version}";
  #     src = appimage;
  #   };

  # });
  qutebrowser = prev.qutebrowser;
}
