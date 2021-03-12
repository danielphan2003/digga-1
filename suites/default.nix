{ lib }:
let
  inherit (builtins) mapAttrs isFunction;
  inherit (lib.flk) mkProfileAttrs profileMap;

  profiles = mkProfileAttrs (toString ../profiles);
  users = mkProfileAttrs (toString ../users);
  userProfiles = mkProfileAttrs (toString ../users/profiles);

  allProfiles =
    let defaults = lib.collect (x: x ? default) profiles;
    in map (x: x.default) defaults;

  allUsers =
    let defaults = lib.collect (x: x ? default) users;
    in map (x: x.default) defaults;


  suites = with profiles; rec {
    base = [ users.root users.pachums usb ];
    boot = [ efi-grub ];
    graphics = [ printing xorg graphical gnome ];
    develop = [ shell nix-builder ];
    sensors = [ location bluetooth sound ];
    desktop = base ++ boot ++ graphics ++ develop ++ sensors;
  };

  userSuites = with userProfiles; rec {
    clibase = with apps; [
      ssh
      zsh
      spacevim
      clibase
    ];

    clifull = with apps; [
      clitools
      development
    ] ++ clibase;

    graphical = with apps; [
      appearance
      firefox
      comms
      office
      media
      gaming
      gnome-extensions
      services.spotifyd
    ];

  };

in
{
  system = mapAttrs (_: v: profileMap v) suites // {
    inherit allProfiles allUsers;
  };
  user = mapAttrs (_: v: profileMap v) userSuites // {
    allProfiles = userProfiles;
  };
}
