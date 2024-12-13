
function _not_inside_tmux
    test -z "$TMUX"
end

function _not_in_vscode
    test "$TERM_PROGRAM" != "vscode"
end

function _not_in_intellij
    test "$TERMINAL_EMULATOR" != "JetBrains-JediTerm"
end

function _not_in_ssh
    test -z "$SSH_CLIENT" && test -z "$SSH_TTY"
end

function ensure_tmux_is_running
    if _not_inside_tmux && _not_in_vscode && _not_in_intellij && _not_in_ssh
        tat
    end
end