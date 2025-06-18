function teleport-ssh
    argparse 'h/help' 'i/internal' -- $argv
    or return

    if set -ql _flag_help
        echo "teleport-ssh [-h|--help] [-i|--internal] <host> [<command>...]" >&2
        return 1
    end

    set -l host $argv[1]
    set -l commands $argv[2..-1]
    if test -z host
        echo "No host provided, aborting" >&2
        return 1
    end

    if set -ql _flag_internal
        set clusterFlag "--cluster"
        set cluster tp-internal.constant.com
        echo "Using internal cluster: $cluster"
        tsh ssh --cluster tp-internal.constant.com root@$host $commands
        return $status
    end

    tsh ssh root@$host $commands
end
