pkgs:
{
z =   pkgs.fetchFromGitHub {
    owner = "rupa";
    repo = "z";
    rev = "4f08e7febba8d024cbf583544a8cd563e02c3413";
    sha256 = "0rx75149wnxmbgys0ayyq61rfv4h19j3d1kh27hqa11k5gf2p0lp";
  };
zsh-bd =   pkgs.fetchFromGitHub {
    owner = "Tarrasch";
    repo = "zsh-bd";
    rev = "d4a55e661b4c9ef6ae4568c6abeff48bdf1b1af7";
    sha256 = "020f8nq86g96cps64hwrskppbh2dapfw2m9np1qbs5pgh16z4fcb";
  };
zsh-autosuggestions =   pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-autosuggestions";
    rev = "ae315ded4dba10685dbbafbfa2ff3c1aefeb490d";
    sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
  };
zsh-history-substring-search =   pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-history-substring-search";
    rev = "0f80b8eb3368b46e5e573c1d91ae69eb095db3fb";
    sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
  };
zsh-completions =   pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-completions";
    rev = "a6e641b977373740e9744182e6fad9af9ff39bc5";
    sha256 = "0v7b1zl6qlgph82lpvj166w9hhw75s4v21fmsd91h7bxcyqcs5qk";
  };
zsh-dwim =   pkgs.fetchFromGitHub {
    owner = "oknowton";
    repo = "zsh-dwim";
    rev = "b4331cc8ec1f2c3bfe559aa975c0e60309a5d20e";
    sha256 = "1a69vfcwmdyqzcs3s1c3s7sy3hdy5mkdxqr01s795j3zv4sfp85k";
  };
zsh-syntax-highlighting =   pkgs.fetchFromGitHub {
    owner = "zsh-users";
    repo = "zsh-syntax-highlighting";
    rev = "dde84e1b25f059a298ce3189cddfd0778f998df3";
    sha256 = "0v69r3xzm385ij1sysqz0w4667cg0vzd87nf23fr47hn46sxblj2";
  };
}
