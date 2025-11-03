function mksh
    set -l script_name $argv[1]
    if test -z $script_name
        echo "mksh requires a script name argument" >&2
        return
    end
    set -l script_path $HOME/bin/$script_name

    if test -e "$script_path"
        echo "$script_path already exists" >&2
        return
    end

    printf '%s\n' '#!/usr/bin/env bash' 'set -euo pipefail' 'IFS=$\'\\n\\t\'' '' > "$script_path"

    chmod u+x "$script_path"

    "$EDITOR" "$script_path"
end
