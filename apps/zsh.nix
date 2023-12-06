{
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
