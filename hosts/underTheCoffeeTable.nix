{ ... }:
{
  imports = [
    #mobile.nixosModules.pine64-pinephone
  ];

  nixpkgs = {
    localSystem = {
      config = "x86_64-unknown-linux-gnu";
      system = "aarch64-linux";
    };

    crossSystem = {
      config = "aarch64-unknown-linux-gnu";
      system = "aarch64-linux";
    };
  };
}
