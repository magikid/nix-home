set -q XDG_CONFIG_HOME || set -U XDG_CONFIG_HOME $HOME/.config

set fish_greeting # Disable greeting
tide configure --auto --style=Classic --prompt_colors='True color' --classic_prompt_color=Dark --show_time=No --classic_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character and frame' --prompt_connection=Disconnected --powerline_right_prompt_frame=Yes --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Many icons' --transient=Yes
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
set -x --prepend PATH $HOME/go/bin
set -x --prepend PATH $HOME/.cargo/bin
set -x --prepend PATH $HOME/.linuxbrew/bin
set -x --prepend PATH $HOME/.config/composer/vendor/bin
set -x --prepend PATH $HOME/.npm/bin
set -x --prepend PATH $HOME/.npm-packages/bin
set -x --prepend PATH $ASDF_DATA_DIR/shims
set -x --append PATH /snap/bin
set -x --append PATH /usr/games
set -x --prepend PATH "$(gem env gemdir)"/bin
set -x --prepend PATH $HOME/.nix-profile/bin
set -x --prepend PATH /nix/var/nix/profiles/default/bin/
set -x --prepend PATH ~/Library/Application\ Support/Coursier/bin
set -x --prepend PATH $HOME/bin

eval "$(mcfly init fish)"
COMPLETE=fish jj | source

if [ (uname) = "Darwin" ]
    export GPG_TTY=$(tty)
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
end

ensure_tmux_is_running
