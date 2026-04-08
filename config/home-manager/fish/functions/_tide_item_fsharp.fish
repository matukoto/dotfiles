function _tide_item_fsharp
    if path is $_tide_parent_dirs/*.fsproj \
        || path is $_tide_parent_dirs/*.sln \
        || path is $_tide_parent_dirs/global.json
        dotnet --version 2>/dev/null | string match -qr "(?<v>[\d.]+)"
        _tide_print_item fsharp $tide_fsharp_icon' ' $v
    end
end
