#!/bin/bash

# run_once_hogehoge は `chezmoi apply` した際に以前に実行されたことがなければ実行されるファイル
# 主にツールのインストールなど、一度だけ実行すれば良いものを記述する

# mise
curl https://mise.run | sh
