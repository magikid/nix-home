function teleport-ssh
    argparse 'h/help' 'i/internal' 'r/root' 'v/verbose' -- $argv
    or return

    if set -ql _flag_help
        echo "teleport-ssh [-h|--help] [-i|--internal] [-r|--root] [-v|--verbose] <host> [<command>...]" >&2
        return 1
    end

    set -l verbose false
    if set -ql _flag_verbose
        set verbose true
        echo "Verbose mode enabled"
    end

    set -l username cjones
    if set -ql _flag_root
        set username root
    end
    if test $verbose = true
        echo "Using username: $username"
    end

    set -l host $argv[1]
    set -l commands $argv[2..-1]
    if test -z host
        echo "No host provided, aborting" >&2
        return 1
    end
    if test $verbose = true
        echo "Connecting to host: $host"
        if test (count $commands) -gt 0
            echo "With commands: $commands"
        else
            echo "No commands provided, starting interactive session"
        end
    end

    if set -ql _flag_internal
        set clusterFlag "--cluster"
        set cluster tp-internal.constant.com
        echo "Using internal cluster: $cluster"
        if test $verbose = true
            echo "Running tsh ssh --cluster $cluster $username@$host $commands"
        end
        tsh ssh --cluster tp-internal.constant.com $username@$host $commands
        return $status
    end

    if test $verbose = true
        echo "Running tsh ssh $username@$host $commands"
    end
    tsh ssh $username@$host $commands
end
