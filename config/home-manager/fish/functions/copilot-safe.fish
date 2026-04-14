function copilot-safe
    set -l current_dir (pwd)
    set -l git_root (command git rev-parse --show-toplevel 2>/dev/null)

    if test -n "$git_root"
        cd "$git_root" || return 1
    end

    command copilot \
        --allow-tool shell \
        --deny-tool "shell(git push)" \
        --deny-tool "shell(rm)" \
        --allow-url github.com \
        --allow-url docs.github.com \
        $argv
    set -l status_code $status

    cd "$current_dir" || return $status_code
    return $status_code
end
