{ config, pkgs, ... }:
{
    programs.fish.enable = true;
    programs.fish.plugins = [
      { name = pkgs.fishPlugins.tide.name; src = pkgs.fishPlugins.tide.src; }
      { name = pkgs.fishPlugins.fzf-fish.name; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
    programs.fish.shellAbbrs = {
      "...." = "cd ../../..";
      "..." = "cd ../..";
      ".." = "cd ..";
      c = "pbcopy";
      code = "codium";
      dcdn = "docker compose down";
      dce = "docker compose exec";
      dclf = "docker compose logs --follow";
      dcps = "docker compose ps";
      dcupd = "docker compose up -d";
      df = "df -hl";
      dirsize = "du -cxh -d 1 | sort -h";
      dr = "docker-run";
      got = "git";
      gut = "git";
      hms = "home-manager switch --flake $XDG_CONFIG_HOME/home-manager";
      j = "jj";
      jf = "just --justfile ~/Justfile";
      kubectx = "kubectl config get-contexts -o name | fzf --tmux | xargs kubectl config use-context";
      ls = "ls -h --color=auto";
      mkdir = "mkdir -p";
      nuke-docker = "docker system prune -a --volumes";
      reload = "source $XDG_CONFIG_HOME/fish/config.fish";
      sail = "sh ([ -f sail ] && echo sail || echo vendor/bin/sail)";
      tp = "teleport-ssh";
      tpi = "teleport-ssh --internal";
      update = "update-nix-stuff";
      v = "pbpaste";
      vi = "nvim";
      vim = "nvim";
    };
    programs.fish.shellInit = (builtins.readFile fish/shellInit.fish);
}
