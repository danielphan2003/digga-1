{ lib, ... }:
# recommend using `hashedPassword`
{
  users.users.root.hashedPassword = lib.fileContents ../../secrets/rootPass;
}
