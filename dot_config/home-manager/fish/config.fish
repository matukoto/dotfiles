# === 環境変数（インタラクティブ・非インタラクティブ共通）===

# XDG Base Directory
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
set -x INITVIM $XDG_CONFIG_HOME/nvim/init.vim
set -x VIMRC $HOME/.vimrc
set -x AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aqua/aqua.yaml

# Fish paths
set -x FISH_CONFIG_DIR $XDG_CONFIG_HOME/fish
set -x FISH_FUNCTIONS_DIR $FISH_CONFIG_DIR/functions
set -x FISH_CACHE_DIR $XDG_CACHE_HOME/fish

# Nix が OS ごとに生成時に差し込む
# __PRIVATE_PLUGIN_ENABLED_LINE__ __BROWSER_LINE__
# __FISH_CONFIG_GENERATION_HASH_LINE__
set -x EDITOR nvim
set -x SYSTEMD_EDITOR "$EDITOR"
set -x TZ Asia/Tokyo

# GPG_TTY: TTY がある場合のみ設定
if tty >/dev/null 2>&1
    set -x GPG_TTY (tty)
end

fish_add_path "$HOME/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.deno/bin"
fish_add_path "$HOME/.local/share/aquaproj-aqua/bin"

if status is-interactive
    if test -f /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    end

    abbr --add f ghf
    abbr --add ai 'aqua i -a'
    abbr --add ag 'aqua g'
    abbr --add mi 'mise i'
    abbr --add skkadd update_skk_dict
    abbr --add skkpull pull_skk_dict
    abbr --add skk 'cd ~/.skk'
    abbr --add fsi 'dotnet fsi'

    # git
    abbr --add s 'git status'
    abbr --add ga 'git add'
    abbr --add gc 'git commit'
    abbr --add gp 'git push'
    abbr --add gpu 'git push --set-upstream origin HEAD'
    abbr --add gpl 'git pull'
    abbr --add gl 'git log'
    abbr --add gs 'git switch'
    abbr --add gd 'git diff'
    abbr --add gsc 'git switch -c'
    abbr --add gcp 'git cherry-pick'
    abbr --add groot 'cd (git rev-parse --show-toplevel)'

    # gh
    abbr --add gas 'gh auth switch'

    # some more ls aliases
    abbr --add ll 'eza -alF --time-style "+%Y/%m/%d %H:%M"'
    abbr --add la 'eza -A'
    abbr --add l 'clear && eza'
    abbr --add ls eza
    abbr --add lc leetcode

    abbr --add v nvim
    abbr --add va 'nvim ~/work/workLog/a.md'
    abbr --add v. 'nvim .'
    abbr --add vr 'nvim ./README.md'
    abbr --add dot 'chezmoi cd'
    abbr --add cu 'pull_skk_dict; and chezmoi update'
    abbr --add ca 'chezmoi apply'
    abbr --add conf 'cd $HOME/.config'

    abbr --add ob 'cd $HOME/obsidian/'
    abbr --add browser-html 'deno run -A --unstable npm:browser-sync  start --server --files "*.html"'
    abbr --add startuptime 'vim-startuptime -count 100 -vimpath nvim'
    abbr --add a aqua
    abbr --add cps 'copilot --allow-tool shell --deny-tool "shell(git push)" --deny-tool "shell(rm)"'
    abbr --add cpy 'copilot --allow-all'
    abbr --add ns "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history"

    # config caches
    set -l CONFIG_CACHE $FISH_CACHE_DIR/config.fish
    set -l CONFIG_CACHE_GENERATION_HASH_FILE $FISH_CACHE_DIR/config.fish.hash
    set -l current_config_generation_hash $FISH_CONFIG_GENERATION_HASH
    # キャッシュ更新が必要かどうかを判定するフラグ
    set -l need_update 0

    # キャッシュファイルが存在しない、または config.fish の世代が変わった場合
    if not test -f "$CONFIG_CACHE"
        set need_update 1
    else if not test -f "$CONFIG_CACHE_GENERATION_HASH_FILE"
        echo "config cache need update"
        set need_update 1
    else
        set -l cached_config_generation_hash (string trim -- (cat "$CONFIG_CACHE_GENERATION_HASH_FILE"))
        if test "$cached_config_generation_hash" != "$current_config_generation_hash"
            echo "config cache need update"
            set need_update 1
        end
    end

    # aqua.yaml が CONFIG_CACHE より新しければツールが更新された可能性があるため再生成
    if test $need_update -eq 0
        if test -f "$AQUA_GLOBAL_CONFIG"; and test "$AQUA_GLOBAL_CONFIG" -nt "$CONFIG_CACHE"
            echo "aqua config updated, updating config cache"
            set need_update 1
        end
    end

    if test $need_update -eq 1
        mkdir -p $FISH_CACHE_DIR
        echo "" >$CONFIG_CACHE

        # tools
        type -q zoxide && zoxide init fish >>$CONFIG_CACHE
        type -q mise && mise activate fish >>$CONFIG_CACHE
        type -q atuin && atuin init --disable-up-arrow fish | string replace --all "atuin uuid" uuidgen >>$CONFIG_CACHE

        printf '%s\n' "$current_config_generation_hash" >$CONFIG_CACHE_GENERATION_HASH_FILE
        echo "config cache updated"
    end
    source $CONFIG_CACHE

end
