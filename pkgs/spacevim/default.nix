{ lib
, stdenv
, ripgrep
, git
, fzf
, makeWrapper
, vim
, neovim
, vimPlugins
, fetchurl
, fetchFromGitHub
, writeTextDir
, runCommand
, remarshal
, formats
, spacevim_config ? import ./init.nix
}:
with stdenv;
let
  format = formats.toml { };
  vim-customized = neovim.override {
    # Not clear at the moment how to import plugins such that
    # SpaceVim finds them and does not auto download them to
    # ~/.cache/vimfiles/repos
    configure.packages.myVimPackage =
      with vimPlugins; { start = [ ]; };
  };
  spacevimConfig = format.generate "init.toml" spacevim_config;
  spacevimDir = runCommand "spacevim_config_dir" { } ''
    mkdir $out
    ln -s ${spacevimConfig} $out/init.toml
  '';

  helptagsPatch = fetchurl {
    url = "https://github.com/NixOS/nixpkgs/raw/master/pkgs/applications/editors/spacevim/helptags.patch";
    sha256 = "1k963y16cixaqp7vrim68hg4km20mmf7x5nwfblj27f4vzyb5l2m";
  };

in
mkDerivation rec {
  pname = "spacevim";
  version = "1.5.0";

  src = fetchFromGitHub {
    owner = "SpaceVim";
    repo = "SpaceVim";
    rev = "v${version}";
    sha256 = "1xw4l262x7wzs1m65bddwqf3qx4254ykddsw3c3p844pb3mzqhh7";
  };

  nativeBuildInputs = [ makeWrapper vim ];
  buildInputs = [ vim ];

  buildPhase = ''
    # generate the helptags
    vim -u NONE -c "helptags $(pwd)/doc" -c q
  '';

  patches = [ helptagsPatch ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r $(pwd) $out/SpaceVim
    # trailing slash very important for SPACEVIMDIR
    makeWrapper "${vim-customized}/bin/nvim" "$out/bin/spacevim" \
        --add-flags "-u $out/SpaceVim/vimrc" --set SPACEVIMDIR "${spacevimDir}/" \
        --prefix PATH : ${lib.makeBinPath [ fzf git ripgrep ]}

    ln -s $out/bin/spacevim $out/bin/vim
  '';

  meta = with lib; {
    description = "Modern Vim distribution";
    longDescription = ''
      SpaceVim is a distribution of the Vim editor that’s inspired by spacemacs.
    '';
    homepage = "https://spacevim.org/";
    license = licenses.gpl3Plus;
    maintainers = [ maintainers.fzakaria ];
    platforms = platforms.all;
  };
}
