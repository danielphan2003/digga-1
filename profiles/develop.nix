{ pkgs, ... }:
let
my-python-packages = python-packages: with python-packages; [
      jedi
      pylint
      pynvim
      pip
      # other python packages you want
    ];
    python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in {
  environment.systemPackages = with pkgs; [
    python-with-my-packages
    nodejs
    yarn
    gparted
  ];

  services.openssh.enable = true;

  environment.variables = { EDITOR = "vim"; };

  ## Program setup
  programs = {
    java.enable = true;
    zsh.enable = true;
    adb.enable = true;
    # plotinus.enable = true;
  };
}



