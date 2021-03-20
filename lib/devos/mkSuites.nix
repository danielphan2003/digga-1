{ lib, dev, ... }:

{ profiles, users, suites }:
let
  inherit (dev) os;

  args = {
    profiles = os.mkProfileAttrs (toString profiles);
    users = os.mkProfileAttrs (toString users);
  };

  definedSuites = (suites { inherit (args) profiles users; }).system;

  allProfiles =
    let defaults = lib.collect (x: x ? default) profiles;
    in map (x: x.default) defaults;

  allUsers =
    let defaults = lib.collect (x: x ? default) users;
    in map (x: x.default) defaults;

in
lib.mapAttrs (_: v: os.profileMap v) definedSuites // {
  inherit allProfiles allUsers;
}
