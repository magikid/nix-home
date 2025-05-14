function teleport
    set -l host $argv[1]
    set -l commands $argv[2..-1]
    if test -z host
        echo "No host provided, aborting"
        return
    end

    tsh ssh root@$host $commands
end