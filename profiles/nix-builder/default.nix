{ ... }:
{
  # nix.buildMachines = [ {
  #   hostName = "builder";
  #   system = "x86_64-linux";
  #   # if the builder supports building for multiple architectures, 
  #   # replace the previous line by, e.g.,
  #   # systems = ["x86_64-linux" "aarch64-linux"];
  #   maxJobs = 4;
  #   speedFactor = 2;
  #   supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
  #   mandatoryFeatures = [ ];
  # }] ;
  nix.distributedBuilds = true;
  nix.trustedUsers = [ "@wheel" ];

  home-manager.users.root = {
    programs.ssh = {
      enable = true;
      matchBlocks.builder = {
        user = "pachums";
        hostname = "myrdd.info";
        port = 4422;
        identitiesOnly = true;
        identityFile = "/root/.ssh/nix_remote";
      };
    };
  };

}
