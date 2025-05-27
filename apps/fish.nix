{ config, pkgs, ... }:
{
    programs.fish.enable = true;
    programs.fish.plugins = [
      { name = pkgs.fishPlugins.tide.name; src = pkgs.fishPlugins.tide.src; }
      { name = pkgs.fishPlugins.fzf-fish.name; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
    programs.fish.shellAbbrs = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      dcdn = "docker compose down";
      dce = "docker compose exec";
      dcps = "docker compose ps";
      dcupd = "docker compose up -d";
      df = "df -hl";
      dirsize = "du -cxh -d 1 | sort -h";
      got = "git";
      gut = "git";
      hms = "home-manager switch --flake $XDG_CONFIG_HOME/home-manager";
      jf = "just --justfile ~/Justfile";
      j = "jj";
      ls = "ls -h";
      mkdir = "mkdir -p";
      nuke-docker = "docker system prune -a --volumes";
      update = "update-nix-stuff";
      vi = "nvim";
      vim = "nvim";
      kubectx = "kubectl config use-context $(kubectl config get-contexts -o name | fzf)";
      reload = "source $XDG_CONFIG_HOME/fish/config.fish";
      tp = "teleport-ssh";
    };
    programs.fish.shellInit = (builtins.readFile fish/shellInit.fish);
}