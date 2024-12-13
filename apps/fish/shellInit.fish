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
    distrobox \
    toolbox \
    terraform \
    aws \
    nix_shell \
    crystal \
    elixir \
    zig \
    jj

set -x NODE_PATH /usr/lib/nodejs:/usr/lib/node_modules:/usr/share/javascript:/usr/local/lib/node_modules
set -x --prepend PATH /usr/local/go/bin
set -x --prepend PATH /usr/local/heroku/bin
set -x --prepend PATH /usr/lib64/qt-3.3/bin
set -x --prepend PATH /usr/bin
set -x --prepend PATH /usr/local/bin
set -x --prepend PATH /usr/local/sbin
set -x --prepend PATH /usr/sbin
set -x --prepend PATH /usr/local/opt/mysql-client/bin
set -x --prepend PATH $HOME/.local/bin
set -x --prepend PATH $HOME/.asdf/shims:$HOME/.asdf/bin
set -x --prepend PATH $HOME/go/bin
set -x --prepend PATH $HOME/.cargo/bin
set -x --prepend PATH $HOME/.linuxbrew/bin
set -x --prepend PATH $HOME/.config/composer/vendor/bin
set -x --prepend PATH $HOME/.npm/bin
set -x --prepend PATH $HOME/.npm-packages/bin
set -x --prepend PATH $HOME/.asdf/installs/haskell/8.6.5/bin
set -x --prepend PATH $HOME/.asdf/installs/golang/1.18.1/packages/bin
set -x --append PATH /snap/bin
set -x --append PATH /usr/games
set -x --prepend PATH $HOME/.nix-profile/bin
set -x --prepend PATH /nix/var/nix/profiles/default/bin/
set -x --prepend PATH ~/Library/Application\ Support/Coursier/bin
set -x --prepend PATH "$(gem env gemdir)"/bin

eval "$(mcfly init fish)"
jj util completion fish | source

ensure_tmux_is_running