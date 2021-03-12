{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    scrcpy
    pypi2nix
    wasm-pack
    cargo-generate
    gradle
    gitAndTools.hub
    ctagsWrapped.ctagsWrapped
    universal-ctags
    rustup

    vscode
    gparted
    unetbootin

    # ventoy

  ];

}
