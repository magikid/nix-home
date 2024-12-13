{ config, pkgs, ... }:
{
    programs.fish.enable = true;
    programs.fish.plugins = [
      { name = pkgs.fishPlugins.tide.name; src = pkgs.fishPlugins.tide.src; }
      { name = pkgs.fishPlugins.fzf-fish.name; src = pkgs.fishPlugins.fzf-fish.src; }
    ];
    programs.fish.shellInit = ''
        set fish_greeting # Disable greeting
        set tide_right_prompt_items \
            status \
            cmd_duration \
            context \
            jobs \
            direnv \
            rustc \
            java \
            pulumi \
            ruby \
            go \
            gcloud \
            kubectl \
            distrobox \
            toolbox \
            terraform \
            aws \
            nix_shell \
            crystal \
            elixir \
            zig \
            jj
    '';
}