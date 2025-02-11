function t
    set -q TMPDIR || set TMPDIR /tmp
    pushd $(mktemp -d $TMPDIR/$1.XXXX)
end