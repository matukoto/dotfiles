# tide 設定
# tide_settings.fish の mtime が変わった場合のみ set -U を実行して起動を高速化する
set -l _tide_settings_file (status filename)
set -l _tide_settings_mtime (stat -f "%m" $_tide_settings_file 2>/dev/null)
if test "$_tide_settings_mtime" = "$tide_settings_mtime"
    return
end
set -U tide_settings_mtime $_tide_settings_mtime

set_color brmagenta --bold --underline
echo "tide settings updated"
set_color normal

# --- prompt layout ---
set -U tide_left_prompt_items os pwd git newline vi_mode character
set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node svelte python rustc java csharp fsharp php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig lua time

set -U tide_left_prompt_frame_enabled false
set -U tide_left_prompt_prefix ''
set -U tide_left_prompt_separator_diff_color ' '
set -U tide_left_prompt_separator_same_color ' '
set -U tide_left_prompt_suffix ' '

set -U tide_right_prompt_frame_enabled false
set -U tide_right_prompt_prefix ' '
set -U tide_right_prompt_separator_diff_color ' '
set -U tide_right_prompt_separator_same_color ' '
set -U tide_right_prompt_suffix ''

set -U tide_prompt_add_newline_before true
set -U tide_prompt_color_frame_and_connection brblack
set -U tide_prompt_color_separator_same_color brblack
set -U tide_prompt_icon_connection '─'
set -U tide_prompt_min_cols 34
set -U tide_prompt_pad_items false
set -U tide_prompt_transient_enabled false

# --- aws ---
set -U tide_aws_bg_color normal
set -U tide_aws_color yellow
set -U tide_aws_icon \uf270

# --- bun ---
set -U tide_bun_bg_color normal
set -U tide_bun_color white
set -U tide_bun_icon \U000f0cd3

# --- character ---
set -U tide_character_color brgreen
set -U tide_character_color_failure brred
set -U tide_character_icon '❯'
set -U tide_character_vi_icon_default '❮'
set -U tide_character_vi_icon_replace '▶'
set -U tide_character_vi_icon_visual V

# --- cmd_duration ---
set -U tide_cmd_duration_bg_color normal
set -U tide_cmd_duration_color brblack
set -U tide_cmd_duration_decimals 0
set -U tide_cmd_duration_icon \uf252
set -U tide_cmd_duration_threshold 3000

# --- context ---
set -U tide_context_always_display false
set -U tide_context_bg_color normal
set -U tide_context_color_default yellow
set -U tide_context_color_root bryellow
set -U tide_context_color_ssh yellow
set -U tide_context_hostname_parts 1

# --- crystal ---
set -U tide_crystal_bg_color normal
set -U tide_crystal_color brwhite
set -U tide_crystal_icon \ue62f

# --- direnv ---
set -U tide_direnv_bg_color normal
set -U tide_direnv_bg_color_denied normal
set -U tide_direnv_color bryellow
set -U tide_direnv_color_denied brred
set -U tide_direnv_icon '▼'

# --- distrobox ---
set -U tide_distrobox_bg_color normal
set -U tide_distrobox_color brmagenta
set -U tide_distrobox_icon \U000f01a7

# --- docker ---
set -U tide_docker_bg_color normal
set -U tide_docker_color blue
set -U tide_docker_default_contexts default colima
set -U tide_docker_icon \uf308

# --- elixir ---
set -U tide_elixir_bg_color normal
set -U tide_elixir_color magenta
set -U tide_elixir_icon \ue62d

# --- gcloud ---
set -U tide_gcloud_bg_color normal
set -U tide_gcloud_color blue
set -U tide_gcloud_icon \U000f02ad

# --- git ---
set -U tide_git_bg_color normal
set -U tide_git_bg_color_unstable normal
set -U tide_git_bg_color_urgent normal
set -U tide_git_color_branch blue
set -U tide_git_color_conflicted red
set -U tide_git_color_dirty blue
set -U tide_git_color_operation red
set -U tide_git_color_staged yellow
set -U tide_git_color_stash white
set -U tide_git_color_untracked green
set -U tide_git_color_upstream red
set -U tide_git_icon ''
set -U tide_git_truncation_length 24
set -U tide_git_truncation_strategy ''

# --- go ---
set -U tide_go_bg_color normal
set -U tide_go_color brcyan
set -U tide_go_icon \ue627

# --- java ---
set -U tide_java_bg_color normal
set -U tide_java_color yellow
set -U tide_java_icon \ue256

# --- jobs ---
set -U tide_jobs_bg_color normal
set -U tide_jobs_color green
set -U tide_jobs_icon \uf013
set -U tide_jobs_number_threshold 1000

# --- kubectl ---
set -U tide_kubectl_bg_color normal
set -U tide_kubectl_color blue
set -U tide_kubectl_icon \U000f10fe

# --- nix_shell ---
set -U tide_nix_shell_bg_color normal
set -U tide_nix_shell_color brblue
set -U tide_nix_shell_icon \uf313

# --- node ---
set -U tide_node_bg_color normal
set -U tide_node_color green
set -U tide_node_icon \ue24f

# --- os ---
set -U tide_os_bg_color normal
set -U tide_os_color brwhite
set -U tide_os_icon \uf179

# --- php ---
set -U tide_php_bg_color normal
set -U tide_php_color blue
set -U tide_php_icon \ue608

# --- private_mode ---
set -U tide_private_mode_bg_color normal
set -U tide_private_mode_color brwhite
set -U tide_private_mode_icon \U000f05f9

# --- pulumi ---
set -U tide_pulumi_bg_color normal
set -U tide_pulumi_color yellow
set -U tide_pulumi_icon \uf1b2

# --- pwd ---
set -U tide_pwd_bg_color normal
set -U tide_pwd_color_anchors brcyan
set -U tide_pwd_color_dirs cyan
set -U tide_pwd_color_truncated_dirs magenta
set -U tide_pwd_icon \uf07c
set -U tide_pwd_icon_home \uf015
set -U tide_pwd_icon_unwritable \uf023
set -U tide_pwd_markers .bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform bun.lockb Cargo.toml composer.json CVS go.mod package.json build.zig pom.xml build.gradle build.gradle.kts .java-version global.json

# --- python ---
set -U tide_python_bg_color normal
set -U tide_python_color cyan
set -U tide_python_icon \U000f0320

# --- ruby ---
set -U tide_ruby_bg_color normal
set -U tide_ruby_color red
set -U tide_ruby_icon \ue23e

# --- rustc ---
set -U tide_rustc_bg_color normal
set -U tide_rustc_color red
set -U tide_rustc_icon \ue7a8

# --- shlvl ---
set -U tide_shlvl_bg_color normal
set -U tide_shlvl_color yellow
set -U tide_shlvl_icon \uf120
set -U tide_shlvl_threshold 1

# --- status ---
set -U tide_status_bg_color normal
set -U tide_status_bg_color_failure normal
set -U tide_status_color green
set -U tide_status_color_failure red
set -U tide_status_icon '✔'
set -U tide_status_icon_failure '✘'

# --- terraform ---
set -U tide_terraform_bg_color normal
set -U tide_terraform_color magenta
set -U tide_terraform_icon \U000f1062

# --- time ---
set -U tide_time_bg_color normal
set -U tide_time_color brblack
set -U tide_time_format '%T'

# --- toolbox ---
set -U tide_toolbox_bg_color normal
set -U tide_toolbox_color magenta
set -U tide_toolbox_icon \ue24f

# --- vi_mode ---
set -U tide_vi_mode_bg_color_default normal
set -U tide_vi_mode_bg_color_insert normal
set -U tide_vi_mode_bg_color_replace normal
set -U tide_vi_mode_bg_color_visual normal
set -U tide_vi_mode_color_default white
set -U tide_vi_mode_color_insert cyan
set -U tide_vi_mode_color_replace green
set -U tide_vi_mode_color_visual yellow
set -U tide_vi_mode_icon_default \ue62b
set -U tide_vi_mode_icon_insert I
set -U tide_vi_mode_icon_replace R
set -U tide_vi_mode_icon_visual V

# --- zig ---
set -U tide_zig_bg_color normal
set -U tide_zig_color yellow
set -U tide_zig_icon \ue6a9

# --- lua ---
set -U tide_lua_bg_color normal
set -U tide_lua_color brblue
set -U tide_lua_icon '🌙'

# --- svelte ---
set -U tide_svelte_bg_color normal
set -U tide_svelte_color brred
set -U tide_svelte_icon \ue697

# --- csharp ---
set -U tide_csharp_bg_color normal
set -U tide_csharp_color magenta
set -U tide_csharp_icon \ue648

# --- fsharp ---
set -U tide_fsharp_bg_color normal
set -U tide_fsharp_color blue
set -U tide_fsharp_icon \ue7a7
