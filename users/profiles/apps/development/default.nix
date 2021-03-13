{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    scrcpy
    pypi2nix
    wasm-pack
    cargo-generate
    gradle
    rustup
    gparted
    unetbootin

    # ventoy

  ];

}
