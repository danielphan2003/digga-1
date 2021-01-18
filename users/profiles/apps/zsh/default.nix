{ config, pkgs, ... }:

{
  programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      dotDir = ".config/zsh";
      # Shell Aliases(aliases)
      shellAliases = {
        cg = "gcalcli --config-folder ~/.config/gcalcli/";
        usctl = "systemctl --user";
        sctl = "sudo systemctl";
        hm = "home-manager";
        nir = "sudo nixos-rebuild";
        eh = "vim ~/.config/nixpkgs/home.nix";
        esc = "sudo vim /etc/nixos/configuration.nix";
        android-mount = "nix-shell -p libmtp jmtpfs --run jmtpfs";
        android-unmount = "nix-shell -p libmtp jmtpfs --run fusermount -u";
        ducks = "du -hsx * | sort -rh | head -10";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "dst";
      };
      plugins = let files = import ./zshPlugins/generated.nix pkgs;
      in [
        {
  	name = "z";
  	file = "z.sh";
  	src = files.z;
        }
        {
  	name = "zsh-bd";
  	src = files.zsh-bd;
        }
        {
  	name = "zsh-autosuggestions";
  	src = files.zsh-autosuggestions;
        }
        {
  	name = "zsh-history-substring-search";
  	src = files.zsh-history-substring-search;
        }
        {
  	name = "zsh-completions";
  	src = files.zsh-completions;
        }
        { 
  	name = "zsh-syntax-highlighting";
  	src = files.zsh-syntax-highlighting;
        }
        {
  	name = "zsh-dwim";
  	src = files.zsh-dwim;
        }
      ];
    };
}
