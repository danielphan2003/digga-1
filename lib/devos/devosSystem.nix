{ lib }:

# dependencies to return a builder
{ self, nixos, inputs }:

{ modules, ... } @ args:
lib.nixosSystem (args // {
  modules =
    let
      modpath = "nixos/modules";

      fullHostConfig = (lib.nixosSystem (args // { inherit modules; })).config;

      isoConfig = (lib.nixosSystem
        (args // {
          modules = modules ++ [
            (lib.modules.iso { inherit self nixos inputs fullHostConfig; })
          ];
        })).config;

      hmConfig = (lib.nixosSystem
        (args // {
          modules = modules ++ [
            (lib.modules.hmConfig)
          ];
        })).config;
    in
    modules ++ [{
      system.build = {
        iso = isoConfig.system.build.isoImage;
        homes = hmConfig.home-manager.users;
      };
    }];
})
