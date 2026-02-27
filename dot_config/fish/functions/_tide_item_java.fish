function _tide_item_java
    if path is $_tide_parent_dirs/pom.xml \
        || path is $_tide_parent_dirs/build.gradle \
        || path is $_tide_parent_dirs/build.gradle.kts \
        || path is $_tide_parent_dirs/settings.gradle \
        || path is $_tide_parent_dirs/settings.gradle.kts \
        || path is $_tide_parent_dirs/*.java \
        || path is $_tide_parent_dirs/.java-version
        java -version &| string match -qr "(?<v>[\d.]+)"
        _tide_print_item java $tide_java_icon' ' $v
    end
end
