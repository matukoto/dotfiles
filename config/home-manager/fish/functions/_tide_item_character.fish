function _tide_item_character
    test $_tide_status = 0 && set_color $tide_character_color || set_color $tide_character_color_failure

    set -q add_prefix || echo -ns ' '

    # Neovim 内、デフォルトキーバインド、または vi_mode アイテムが左プロンプトにある場合は常に ❯ を表示
    # （vi_mode アイテムがモード表示を担うため character 側では不要）
    if set -q NVIM
        or test "$fish_key_bindings" = fish_default_key_bindings
        or contains vi_mode $tide_left_prompt_items
        echo -ns $tide_character_icon
    else
        switch $fish_bind_mode
            case insert
                echo -ns $tide_character_icon
            case default
                echo -ns $tide_character_vi_icon_default
            case replace replace_one
                echo -ns $tide_character_vi_icon_replace
            case visual
                echo -ns $tide_character_vi_icon_visual
        end
    end
end
