function _tide_item_svelte
    if path is $_tide_parent_dirs/package.json
        set -l package_json
        for dir in $_tide_parent_dirs
            set -l candidate "$dir/package.json"
            if test -f "$candidate"
                set package_json "$candidate"
                break
            end
        end

        if test -z "$package_json"
            return
        end

        set -e v
        cat "$package_json" | string match -rqg '"svelte":\s*"[~^]?(?<v>[^"]+)"'
        if test -n "$v"
            _tide_print_item svelte $tide_svelte_icon' ' $v
        end
    end
end
