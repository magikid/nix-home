{ config, pkgs, ... }:
{
    programs.fish.enable = true;
    programs.fish.plugins = [
      { name = pkgs.fishPlugins.tide.name; src = pkgs.fishPlugins.tide.src; }
      { name = pkgs.fishPlugins.fzf-fish.name; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
    programs.fish.shellAbbrs = {
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
      j = "jj";
      jf = "just --justfile ~/Justfile";
      ls = "ls -h --color=auto";
      mkdir = "mkdir -p";
      nuke-docker = "docker system prune -a --volumes";
      reload = "source $XDG_CONFIG_HOME/fish/config.fish";
      tp = "teleport-ssh";
      tpi = "teleport-ssh --internal";
      update = "update-nix-stuff";
      v = "pbpaste";
      vi = "nvim";
      vim = "nvim";
    };
    programs.fish.shellAliases = {
      "...." = "cd ../../..";
      "..." = "cd ../..";
      ".." = "cd ..";
      hms = "home-manager switch --flake $XDG_CONFIG_HOME/home-manager";
      kubectx = "kubectl config get-contexts -o name | fzf --tmux | xargs kubectl config use-context";
      sail = "sh ([ -f sail ] && echo sail || echo vendor/bin/sail)";
    };
    programs.fish.shellInit = (builtins.readFile fish/shellInit.fish);
}
