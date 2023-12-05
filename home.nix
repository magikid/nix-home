{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "chrisj";
  home.homeDirectory = "/home/chrisj";
  home.language.base = "en_US.UTF-8";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    pkgs.backblaze-b2
    pkgs.bat
    pkgs.bc
    pkgs.cowsay
    pkgs.delta
    pkgs.fd
    pkgs.glibcLocales
    pkgs.graphviz
    pkgs.htop
    pkgs.jq
    pkgs.just
    pkgs.kcachegrind
    pkgs.magic-wormhole
    pkgs.mosh
    pkgs.mpd
    pkgs.ncdu
    pkgs.ncmpcpp
    pkgs.pv
    pkgs.tailscale
    pkgs.tmux
    pkgs.vagrant
    pkgs.vlc

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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

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
    LOCALES_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    DELTA_PAGER="less --mouse --wheel-lines=3";
    PAGER = "delta --relative-paths --diff-highlight --paging always --max-line-length 0";
    PROMPT = "%(?:$emoji[smiling_face_with_sunglasses]:$emoji[fire])  $PROMPT";
    QT_SELECT = 5;
    PYENV_ROOT="$HOME/.pyenv";
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

    PATH = "$HOME/.bin:$HOME/bin:$PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.fzf.defaultCommand = ''rg --files --hidden --follow --color=never --glob=\"!**/.git/\"'';
  programs.fzf.tmux.enableShellIntegration = true;
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    aliases = {
      ap = "add -p";
      b = "branch";
      bd = "branch -d";
      cia = "commit --amend";
      cian = "commit --amend --no-edit";
      ci = "commit -v";
      cif = "commit -v --fixup";
      cob = "switch --create";
      co = "checkout";
      cp = "cherry-pick";
      default-branch = "!git symbolic-ref refs/remotes/origin/HEAD | cut -f4 -d/";
      ds = "diff --staged";
      ignored = ''!git ls-files -v | grep "^S"'';
      ignore = "update-index --skip-worktree";
      ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';
      pf = "push --force-with-lease";
      rem = "!git rebase $(git default-branch)";
      remi = "!git rebase -i $(git default-branch)";
      r = "restore";
      "rec" = "rebase --continue";
      rea = "rebase --abort";
      rs = "restore --staged";
      sc = "switch --create";
      set-upstream-to-track-origin-same-branch-name = "!git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`";
      sf = "!git branch | fzf | xargs git switch";
      sla = "log --oneline --decorate -60";
      slap = "log --oneline --decorate --graph --all";
      sl = "log --oneline --decorate -20";
      s = "switch";
      st = "status";
      uncommit = "reset HEAD^";
      unignore = "update-index --no-skip-worktree";
      unstage = "restore --staged";
      up = ''!git fetch --prune --auto-maintenance origin && git fetch -f origin "$(git default-branch):$(git default-branch)"'';
      wip = ''!git add . && git commit -nm "WIP"'';
      gone = ''! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" {print $1}' | xargs -r git branch -D'';
    };
    delta.enable = true;
    delta.options = {
      features = "decorations";
      line-numbers = true;
      syntax-theme = "Monokai Extended";
    };
    extraConfig = {
      features = {
        manyFiles = true;
      };
    };
    userName = "Chris W Jones";
    userEmail = "chris@christopherjones.us";
    signing = {
      key = "CB9F3B58E8E17327";
      signByDefault = true;
    };
  };

  programs.ripgrep.arguments = [
    "--max-columns=500"
    "--pretty"
    "--smart-case"
    "--threads=8"
  ];
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    history = {
      extended = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "$HOME/.zsh_history";
      share = true;
      size = 999999999;
    };
    oh-my-zsh = {
      enable = true;
      theme = "lambda";
      plugins = [
        "asdf"
        "composer"
        "docker-compose"
        "docker"
        "emoji"
        "fzf"
        "gitfast"
        "mercurial"
        "mix"
        "poetry"
        "vim-interaction"
        "virtualenv"
      ];
    };
    plugins = [{
      name = "fzf-tab";
      src = pkgs.fetchFromGitHub {
        owner = "marlonrichert";
        repo = "zsh-autocomplete";
        rev = "23.07.13";
        sha256 = "0NW0TI//qFpUA2Hdx6NaYdQIIUpRSd0Y4NhwBbdssCs=";
      };
    }];
    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      b2 = "backblaze-b2";
      bc = "bc -l";
      c = "xclip -selection clipboard";
      df = "df -hl";
      got = "git";
      hms = "home-manager switch";
      j = "just --working-directory . --justfile ~/Justfile";
      ls = "ls -h";
      ni = "nix-env -i";
      nl = "nix-env -q";
      nq = "nix-env -qaP";
      ns = "nix-search";
      t = "todo.sh";
      v = "xclip -o";
      vi = "nvim";
      vim = "nvim";
    };

    initExtra = ''
      source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/zoxide/zoxide.plugin.zsh

      if [ -r ~/.zshrc.local ]; then
        source ~/.zshrc.local
      fi

      source "$HOME/.cargo/env"

      export NODE_PATH=/usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript:/usr/local/lib/node_modules

      export PATH=/usr/local/go/bin:$PATH
      export PATH=/usr/local/heroku/bin:$PATH
      export PATH=/usr/lib64/qt-3.3/bin:$PATH
      export PATH=/usr/bin:$PATH
      export PATH=/usr/local/bin:$PATH
      export PATH=/usr/local/sbin:$PATH
      export PATH=/usr/sbin:$PATH
      export PATH=/usr/local/opt/mysql-client/bin:$PATH
      export PATH=$HOME/.local/bin:$PATH
      export PATH=$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH
      export PATH=$HOME/go/bin:$PATH
      export PATH=$HOME/.cargo/bin:$PATH
      export PATH=$HOME/.linuxbrew/bin:$PATH
      export PATH=$HOME/.config/composer/vendor/bin:$PATH
      export PATH=$HOME/.npm/bin:$PATH
      export PATH=$HOME/.npm-packages/bin:$PATH
      export PATH=$HOME/.asdf/installs/haskell/8.6.5/bin:$PATH
      export PATH=$HOME/.asdf/installs/golang/1.18.1/packages/bin:$PATH
      export PATH=$PATH:/snap/bin
      export PATH=$PATH:/usr/games

      autoload -U +X bashcompinit && bashcompinit

      compdef g=git
      setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
      setopt SHARE_HISTORY             # Share history between all sessions.
      setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
      setopt HIST_BEEP                 # Beep when accessing nonexistent history.

      add_old_gpg_key() {
        curl $1 | gpg --dearmor | sudo tee /usr/share/keyrings/$2.gpg > /dev/null
      }

      g() {
        if [[ $# > 0 ]]; then
          git $@
        else
          git status
        fi
      }

      archive-folder() {
        if [[ -z "$1" ]]; then
          echo "Missing folder to archive"
          return
        fi

        local folder_name="$1"
        local gzip_file="$folder_name-$(date +%Y-%m-%d).tar.gz"
        echo "gziping folder"
        tar -czf "$gzip_file" "$folder_name"
        ls -havl "$gzip_file"
        echo -n "Delete folder $folder_name? [y/n] "
        read delete_response

        if [[ "$delete_response" == "y" ]] || [[ "$delete_response" == "Y" ]]; then
          echo "Deleting $folder_name..."
          sleep 5
          rm -r "$folder_name"
        else
          echo "Skipping file deletion"
          return
        fi
      }

      dirsize(){
        du -cxh -d 1 | sort -h
      }

      # Add this to your zshrc or bzshrc file
      _not_inside_tmux() { [[ -z "$TMUX" ]] }
      _not_in_vscode() { [[ $TERM_PROGRAM != "vscode" ]] }
      _not_in_intellij() { [[ $TERMINAL_EMULATOR != "JetBrains-JediTerm" ]] }

      ensure_tmux_is_running() {
        if _not_inside_tmux && _not_in_vscode && _not_in_intellij; then
          tat
        fi
      }

      ensure_tmux_is_running
    '';
  };
}
