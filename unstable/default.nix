{
  # modules to pull from master, stable version is automatically disabled
  modules = [ ];

  # if a modules name changed in master, add the old name here
  disabledModules = [ ];

  # packages pulled from master
  packages = pkgs: final: prev: {
    inherit (pkgs)
      discord
      element-desktop
      manix
      nixpkgs-fmt;

  };
}
