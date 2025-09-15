function docker-run
    argparse 'h/help' 'n/name=' -- $argv
    or return

    if set -ql _flag_help
        echo "docker-run [-h|--help] [-n|--name <container_name>] <image> [<command>...]" >&2
        return 1
    end

    set -l image $argv[1]
    set -l commands $argv[2..-1]
    if test -z image
        echo "No image provided, aborting" >&2
        return 1
    end
    if test -z commands
        set commands "/bin/sh"
    end

    set -l common_flags "-it -v $PWD:/app -w /app -v $HOME/ca_certs:/ca_certs:ro"
    if set -ql _flag_name
        docker run $common_flags --name $_flag_name $image $commands
    else
        docker run --rm $common_flags $image $commands
    end
end
