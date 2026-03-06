function _tide_item_lua
    if path is $_tide_parent_dirs/*.lua || path is $_tide_parent_dirs/.lua-version
        lua -v 2>&1 | string match -qr "Lua (?<v>[\d.]+)"
        _tide_print_item lua $tide_lua_icon' ' $v
    end
end
