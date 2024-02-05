{
  programs.git = {
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
      ur = "!git up && git rem";
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
      merge = {
        tool = "meld";
        conflictStyle = "zdiff3";
        ff = "only";
      };

      diff = {
        tool = "meld";
        colorMoved = "default";
      };

      push = {
        default = "current";
      };

      commit = {
        template = "~/.gitmessage";
        gpgsign = true;
      };

      rebase = {
        autosquash = true;
      };

      transfer = {
        fsckobjects = true;
      };

      fetch = {
        fsckobjects = true;
        parallel = 0;
        prune = true;
      };

      receive = {
        fsckobjects = true;
      };

      include = {
        path = ".gitconfig.local";
      };

      init = {
        templatedir = "/home/chrisj/.git-templates";
        defaultBranch = "main";
      };

      rerere = {
        enabled = true;
      };

      core = {
        excludesfile = "/home/chrisj/.gitignore_global";
        autocrlf = "input";
        attributesfile = "/home/chrisj/.gitattributes";
      };

      filter = {
        "lfs" = {
            clean = "git-lfs clean -- %f";
            smudge = "git-lfs smudge -- %f";
            process = "git-lfs filter-process";
            required = true;
          };
      };

      sendemail = {
        smtpserver = "smtp.fastmail.com";
        smtpuser = "magikid@fastmail.fm";
        smtpencryption = "tls";
        smtpserverport = 465;
      };

      mergetool = {
        keepBackup = false;
      };

      pull = {
        ff = "only";
        rebase = true;
      };

      credential = {
        helper = "cache";
      };

      help = {
        autocorrect = "prompt";
      };

      color = {
        ui = "auto";
      };

      features = {
        manyFiles = true;
      };

      maintenance = {
        repo = "/home/chrisj/projects/catalog";
      };
      remote = {
        gitlab = {
          fetch = "+refs/merge-requests/*:refs/remotes/gitlab/merge-requests/*";
        };
      };
    };
    includes = [
      {
        path = "~/.gitconfig.work";
        condition = "gitdir:~/projects/";
      }
      {
        path = "~/.gitconfig.personal";
        condition = "gitdir:~/personal-projects/";
      }
      {
        path = "~/.gitconfig.personal";
        condition = "gitdir:~/go/";
      }
    ];
    lfs.enable = true;
    signing = {
      key = "CB9F3B58E8E17327";
      signByDefault = true;
    };
    userName = "Chris W Jones";
    userEmail = "chris@christopherjones.us";
  };
}
