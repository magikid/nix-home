function mkcd
    set -l dir_name $argv[1]
    if test -z $dir_name
        echo "mkcd requires a directory name argument" >&2
        return
    end

    if test -e "$dir_name"
        cd "$dir_name"
        return
    end

    mkdir -p "$dir_name"
    cd "$dir_name"
end
