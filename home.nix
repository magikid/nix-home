{ config, pkgs, lib, pkgsUnstable, ... }:

let
  seasonal-themes = builtins.fetchGit {
    url = "https://github.com/jottenlips/seasonal-zshthemes.git";
    rev = "e99d4850abdd7eef68f0c04ef395d2a00cd782ee";
  };
  customDir = pkgs.stdenv.mkDerivation {
    name = "oh-my-zsh-custom-dir";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/themes
      cp ${seasonal-themes}/*.zsh-theme $out/themes/
      cp ${seasonal-themes}/get_theme_season.sh $out/get_theme_season.sh
    '';
  };
  homeDirectory = if pkgs.system == "aarch64-darwin" then "/Users/chrisj" else "/home/chrisj";
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "phpstorm-2023.2.3"
      ];
    };
  };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "chrisj";
  home.homeDirectory = homeDirectory;
  home.language.base = "en_US.UTF-8";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./apps/git.nix
    ./apps/ssh.nix
    ./apps/zsh.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    pkgs.age
    pkgs.bat
    pkgs.bc
    pkgs.borgbackup
    pkgs.cacert
    pkgs.cowsay
    pkgs.delta
    pkgs.docker-compose
    pkgs.dockutil
    pkgs.fd
    pkgs.gawk
    pkgs.graphviz
    pkgs.htop
    pkgs.jq
    pkgs.just
    pkgs.magic-wormhole
    pkgs.mosh
    pkgs.mpd
    pkgs.ncmpcpp
    pkgs.neovim
    pkgs.pv
    pkgs.rsync
    pkgs.tailscale
    pkgs.tmux
    pkgs.watchman
    pkgs.wget

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (pkgs.writeShellScriptBin "update-nix-stuff"
      (builtins.readFile bin/update-nix-stuff.sh))

    (pkgs.writeShellScriptBin "tat"
      (builtins.readFile bin/tat.sh))
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".agignore".text = ''
      node_modules
      bower_components
      git
      hg
      svn
    '';

    ".ansible.cfg".source = text/ansible.cfg;
    ".gitattributes".source = text/gitattributes;
    ".gitmessage".source = text/gitmessage;
    ".tmux.conf".source = text/tmux.conf;
    ".gitignore_global".source = text/gitignore_global;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/chrisj/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    DELTA_PAGER="less --mouse --wheel-lines=3";
    PAGER = "delta --relative-paths --diff-highlight --paging always --max-line-length 0";
    PROMPT = "%(?:$emoji[smiling_face_with_sunglasses]:$emoji[fire])  $PROMPT";
    QT_SELECT = 5;
    PYENV_ROOT="${config.home.homeDirectory}/.pyenv";
    LESS = "-R";

    # Set the locale. This affects the encoding of files, the
    # classification of character properties, and the behavior of
    # regular expressions, among other things.
    LC_ALL = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
    LANGUAGE = "en_US.UTF-8";

    # Tell docker-compose to use `docker` to build stuff
    COMPOSE_DOCKER_CLI_BUILD = 1;
    DOCKER_CLI_EXPERIMENTAL = "enabled";

    # zsh config
    UPDATE_ZSH_DAYS = 14;
    HYPHEN_INSENSITIVE = "true"; # use hyphen-insensitive completion. _ and - will be interchangeable.
    ENABLE_CORRECTION = "false"; # enable command auto-correction.
    COMPLETION_WAITING_DOTS = "true"; # display red dots whilst waiting for completion.
    HIST_STAMPS = "mm/dd/yyyy"; # stamp shown in the history command output. three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"

    PATH = "${config.home.homeDirectory}/.bin:${config.home.homeDirectory}/bin:$PATH";
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.fzf.defaultCommand = ''rg --files --hidden --follow --color=never --glob=\"!**/.git/\"'';
  programs.fzf.tmux.enableShellIntegration = true;

  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.iniContent.core.pager = lib.mkForce "delta --relative-paths --diff-highlight --paging always --max-line-length 0";
  programs.git.iniContent.interactive.diffFilter = lib.mkForce "delta --color-only --features=interactive";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.jujutsu = {
    package = pkgsUnstable.jujutsu;
    enable = true;
    settings = {
      user = {
        name = "Chris W Jones";
        email = "chris@christopherjones.us";
      };
      template-alises = {
        "format_short_id(id)" = "id.shortest()";
      };
      aliases = {
        "l" = ["log" "-r" "(trunk()..@):: | (trunk()..@)-"];
        "lb" = ["log" "-r" "@ | root() | master::bookmarks(chrisj)"];
        "rbm" = ["rebase" "-d" "master"];
      };
      snapshot = {
        max-new-file-size = "10MiB";
      };
      core = {
        fsmonitor = "watchman";
      };
    };
  };

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=500"
      "--pretty"
      "--smart-case"
      "--threads=8"
    ];
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    plugins = [{
      name = "fzf-tab";
      src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "23.07.13";
          sha256 = "0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
      };
    }];
    initExtra = ''
      source "${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/zoxide/zoxide.plugin.zsh";
    '';
    oh-my-zsh.custom = "${customDir}";
    oh-my-zsh.theme = "jtriley";
  };
}
