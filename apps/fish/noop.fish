function print_noop_help
    echo "Usage: noop [-h|--help] [-q|--query '<teleport query>'] [-o|--op] [-r|--reason <ticket>]" | ts >&2
end

function noop
    argparse 'h/help' 'q/query=' 'o/op' 'r/reason=' -- $argv
    or return

    if set -q _flag_help
        print_noop_help
        return 1
    end

    set -l operation "--noop"
    if not set -q _flag_reason
        if not set -q _flag_op
            echo "Missing noop reason" | ts >&2
            print_noop_help
            return 1
        else
            set operation "--op"
        end
    else
        set operation "--noop --reason $_flag_reason"
    end

    if ! set -q _flag_query
        echo "Missing teleport query" | ts >&2
        print_noop_help
        return 1
    end

    for host in $(tsh ls --query $_flag_query --format=names)
        echo "$host: Running noop-puppet $operation" | ts
        teleport-ssh $host "sudo /usr/local/sbin/noop-puppet $operation"
    end
end