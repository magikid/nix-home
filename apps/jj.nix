{ pkgs, pkgsUnstable, ... }:
{
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
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };
      aliases = {
        "bc" = ["bookmark" "create"];
        "bookmark-last" = ["bookmark" "set" "-r" "@-"];
        "colo" = ["git" "init" "--colocate"];
        "gf" = ["git" "fetch"];
        "gp" = ["git" "push"];
        "gpc" = ["git" "push" "--change"];
        "gpn" = ["git" "push" "--allow-new"];
        "l" = ["log" "-r" "(trunk()..@):: | (trunk()..@)-"];
        "lb" = ["log" "-r" "@ | root() | master::bookmarks(chrisj)"];
        "nms" = ["new" "master@origin"];
        "nmn" = ["new" "main@origin"];
        "nb" = "jj bookmark list -T 'surround(\"\", \"\n\", self.name())' | fzf --tmux | xargs jj new";
        "master-rebase" = ["rebase" "-d" "master"];
        "master-track" = ["bookmark" "track" "master@origin"];
        "main-rebase" = ["rebase" "-d" "main"];
        "main-track" = ["bookmark" "track" "main@origin"];
        "my-bookmarks" = ["log" "-r" "bookmarks() & (mine() | committer('chris@christopherjones.us') | committer('cjones@vultr.com'))" "--no-graph" "--template" "pad_start(5, self.change_id().shortest()) ++ ' ' ++ pad_start(15, self.committer().timestamp().local().ago()) ++ ' ' ++ self.bookmarks() ++ \"\n\""];
        "nwe" = ["new"];
        "tug" = ["bookmark" "move" "--from" "heads(::@- & bookmarks())" "--to" "@-"];
        "wip" = ["bookmark" "set" "wip" "-r" "@"];
      };
      snapshot = {
        max-new-file-size = "10MiB";
      };
      core = {
        fsmonitor = pkgs.watchman.pname;
      };
      git = {
        write-change-id-header = true;
      };
      ui = {
        default-command = "status";
        pager = "delta";
      };
    };
  };
}