{ suites, ... }:
{
  imports = suites.base ;

  home-manager.users.pachums = { suites, ... }: {
    imports = suites.clifull;
  };

}
