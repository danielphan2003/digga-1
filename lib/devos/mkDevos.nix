{ self, nixos, inputs, ... }:
let
  devos = self;

  argOpts = with nixos.lib; { config, ... }:
    let
      cfg = config;
      mkPathOpt = name: mkOption {
        type = types.path;
        default = "${cfg.self}/${name}";
        defaultText = "\${self}/${name}";
      };
      mkTypeOpt = name: type: mkOption {
        type = with types; oneOf [ path type ];
        default = import "${cfg.self}/${name}";
        defaultText = "import \${self}/${name}";
        apply = x: if builtins.isPath x then import x else x;
      };

      inputAttrs = types.functionTo types.attrs;
    in
    {
      options = {
        self = mkOption {
          type = with types; addCheck attrs nixos.lib.isStorePath;
          description = "The flake to create the devos outputs for";
        };
        hosts = mkPathOpt "hosts" // {
          description = "Path to all host configurations";
        };
        packages = mkTypeOpt "pkgs"
          (with types; functionTo inputAttrs) // {
            description = "overlay for custom packages";
          };
        modules = mkTypeOpt "modules/module-list.nix" (with types; listOf anything) // {
          description = "list of modules to include in confgurations";
        };
        profiles = mkPathOpt "profiles" // {
          description = "path to profiles folder";
        };
        suites = mkTypeOpt "suites" inputAttrs // {
          description = ''
            function with inputs 'users' and 'profiles' that returns attribute 'system'
            which defines suites passed to configurations as the suites specialArg
          '';
        };
        users = mkPathOpt "users" // {
          description = "path to folder containing user profiles";
        };
        extern = mkTypeOpt "extern" inputAttrs // {
          description = ''
            function with input 'inputs' with all devos and this flake's inputs
            that returns modules, overlays, and specialArgs to be included across devos
          '';
        };
        overlays = mkPathOpt "overlays" // {
          description = "path to folder containing overlays which will be applied to pkgs";
        };
        overrides = mkTypeOpt "overrides" types.attrs // {
          description = "attrset of packages and modules that will be pulled from nixpkgs master";
        };
      };
    };
in

{ ... } @ args:
let
  inherit (self) lib;
  inherit (lib) os;

  inherit (inputs) utils deploy;

  cfg = (nixos.lib.evalModules { modules = [ args argOpts ]; }).config;

  external = cfg.extern { inputs = inputs // self.inputs; };

  multiPkgs = os.mkPkgs { inherit (cfg) overrides; extern = external; };

  allSuites = os.mkSuites { inherit (cfg) profiles users suites; };

  outputs = {
    nixosConfigurations = os.mkHosts {
      inherit multiPkgs;
      inherit (cfg) overrides;
      extern = external;
      suites = allSuites;
      dir = cfg.hosts;
    };

    nixosModules = lib.pathsToImportedAttrs cfg.modules;

    overlay = cfg.packages;
    #overlays = lib.pathsToImportedAttrs (lib.pathsIn (builtins.toPath overlays));
    overlays = lib.pathsToImportedAttrs (lib.pathsIn ../../overlays);

    lib = import "${devos}/lib" { inherit self nixos inputs; };

    templates.flk.path = ./.;
    templates.flk.description = "flk template";
    defaultTemplate = self.templates.flk;

    deploy.nodes = os.mkNodes deploy self.nixosConfigurations;
  };

  systemOutputs = utils.lib.eachDefaultSystem (system:
    let pkgs = multiPkgs.${system}; in
    {
      checks =
        let
          tests = nixos.lib.optionalAttrs (system == "x86_64-linux")
            (import "${devos}/tests" { inherit self pkgs; });
          deployHosts = nixos.lib.filterAttrs
            (n: _: self.nixosConfigurations.${n}.config.nixpkgs.system == system) self.deploy.nodes;
          deployChecks = deploy.lib.${system}.deployChecks { nodes = deployHosts; };
        in
        nixos.lib.recursiveUpdate tests deployChecks;

      packages = utils.lib.flattenTreeSystem system
        (os.mkPackages { inherit pkgs; });

      devShell = import "${devos}/shell" {
        inherit self pkgs system;
      };

      legacyPackages.hmActivationPackages =
        os.mkHomeActivation;
    });
in
 nixos.lib.recursiveUpdate outputs systemOutputs

