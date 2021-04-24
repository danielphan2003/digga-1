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
    builder = os.devosSystem;
    inherit (cfg.os.hostDefaults)
      channelName
      system;
  };

  hosts =




    }


      multiPkgs = os.mkPkgs
  {
  inherit self inputs nixos;
  inherit (cfg) extern overrides;
};

outputs = {
nixosConfigurations = os.mkHosts
{
inherit self inputs nixos multiPkgs;
inherit (cfg) extern suites overrides;
dir = cfg.hosts;
};

homeConfigurations = os.mkHomeConfigurations self.nixosConfigurations;

nixosModules = cfg.modules;

homeModules = cfg.userModules;

overlay = cfg.packages;
inherit (cfg) overlays;

deploy.nodes = os.mkNodes deploy self.nixosConfigurations;
};

systemOutputs = lib.eachDefaultSystem (system:
let
pkgs = multiPkgs.${system};
pkgs-lib = lib.pkgs-lib.${system};
# all packages that are defined in ./pkgs
legacyPackages = os.mkPackages {
inherit pkgs;
inherit (self) overlay overlays;
};
in
{
checks = pkgs-lib.tests.mkChecks {
inherit (self.deploy) nodes;
hosts = self.nixosConfigurations;
homes = self.homeConfigurations;
};

inherit legacyPackages;
packages = lib.filterPackages system legacyPackages;

devShell = pkgs-lib.shell;
});
in
outputs // systemOutputs

