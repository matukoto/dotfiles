function _tide_item_svelte
    if path is $_tide_parent_dirs/package.json
        cat $_tide_parent_dirs/package.json | string match -rqg '"svelte":\s*"[~^]?(?<v>[^"]+)"'
        if test -n "$v"
            _tide_print_item svelte $tide_svelte_icon' ' $v
        end
    end
end
