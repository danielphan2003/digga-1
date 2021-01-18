{ nixosConfigurations
, lib
, pkgs
, home
, system
, ...
}:
with lib;

let
  mkHMConfig = systemcfg: name: hmcfg: 
    let
      usercfg = systemcfg.config.users.users."${name}";
    in home.lib.homeManagerConfiguration {
      inherit system pkgs;
      configuration = { ... }: {
        imports = [ hmcfg.config ];
      };
      homeDirectory = usercfg.home;
      username = name;
    };
  mapHMConfig = _: nixosConfig: builtins.mapAttrs (mkHMConfig nixosConfig) nixosConfig.config.home-manager.users;

in builtins.mapAttrs mapHMConfig nixosConfigurations 


