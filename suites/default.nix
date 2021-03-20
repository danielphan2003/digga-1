{ profiles, users }:

{
  system = with profiles; rec {
    base = [ users.nixos users.root ];
  };
}
