function t
    set idea $argv[1]
    set -q TMPDIR || set TMPDIR /tmp
    set workdir "$(mktemp -d $TMPDIR/$idea.XXXX)"
    echo "Moving to $workdir, popd to get back"
    pushd $workdir
end