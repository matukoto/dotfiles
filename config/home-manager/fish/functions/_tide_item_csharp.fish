function _tide_item_csharp
    if path is $_tide_parent_dirs/*.csproj \
        || path is $_tide_parent_dirs/*.sln \
        || path is $_tide_parent_dirs/global.json
        dotnet --version 2>/dev/null | string match -qr "(?<v>[\d.]+)"
        _tide_print_item csharp $tide_csharp_icon' ' $v
    end
end
