#!/usr/bin/env fish

function ns-skim-open-files-from-root
    if ! type -q $NS_FD
        echo "fd is not installed.  Please read the README on where you can find it."
        commandline -f repaint
        return 1
    end

    if ! type -q $NS_SKIM
        echo "skim/sk is not installed.  Please read the README on where you can find it."
        commandline -f repaint
        return 1
    end

    set -l get_files_cmd "$NS_FD --hidden --no-ignore --full-path --exclude .git --type f '\.*' /"
    set -l selected_files (eval "$get_files_cmd" | env SKIM_DEFAULT_OPTIONS="--prompt 'Open: ' -m $NS_SKIM_NAVIGATION_OPTS" $NS_SKIM)
    if test -n "$selected_files"
       sudo emacs "$selected_files" -nw < /dev/tty
    end
    commandline -f repaint
    return $status
end
