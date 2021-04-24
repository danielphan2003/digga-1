{ lib, deploy }:
let
  inherit (lib) os;
  inherit (builtins) mapAttrs attrNames;
in

_: { self, inputs, nixos, ... } @ args:
let

  config = (
    lib.mkFlake.evalArgs
      { inherit self inputs args; }
  );

  cfg = config.config;

  otherArguments = removeAttrs args (attrNames config.options);
in
lib.systemFlake
  lib.recursiveUpdate
  otherArguments
{
  inherit self inputs;

  channels = mapAttrs
    (n: c:
      c // {
        # TODO: figure out what to do with channels arg from fup
        overlaysBuilder = channels: (attrValues c.overlays) ++ (attrValues c.externalOverlays);
      };
    ) cfg.channels;

  hostDefaults = {
    specialArgs.suites = cfg.os.suites;
    modules = cfg.os.hostDefaults.modules
      ++ cfg.os.hostDefaults.externalModules
      [ ]
    ;
    builder = os.devosSystem { inherit self nixos inputs; };
    inherit (cfg.os.hostDefaults)
      channelName
      system;
  };

  nixosModules = lib.exporters.moduleFromListExporter cfg.os.hostDefaults.modules;

  overlays = lib.exporters.overlaysFromChannelsExporter cfg.channels;
  packagesBuilder = lib.builders.packagesFromOverlaysBuilderConstructor self.pkgs;

  homeModules = lib.exporters.moduleFromListExporter cfg.home.modules;
  homeConfigurations = os.mkHomeConfigurations self.nixosConfigurations;

  deploy.nodes = os.mkNodes deploy self.nixosConfigurations;

  checksBuilder = channels:
    let
      pkgs-lib =
        pkgs-lib.tests.mkChecks {
          inherit (self.deploy) nodes;
          hosts = self.nixosConfigurations;
          homes = self.homeConfigurations;
        };



      outputs = {
        nixosConfigurations = os.mkHosts
          {
            inherit self inputs nixos multiPkgs;
            inherit (cfg) extern suites overrides;
            dir = cfg.hosts;
          };

      };

      systemOutputs = lib.eachDefaultSystem (system:
        let
          pkgs-lib = lib.pkgs-lib.${system};
          # all packages that are defined in ./pkgs
          };
          in
          {
          checks = ;

            inherit legacyPackages;
          packages = lib.filterPackages system legacyPackages;

          devShell = pkgs-lib.shell;
          });
          in
          outputs // systemOutputs

