-- Gitグラフ表示プラグイン（gitgraph.nvim）の設定
-- Gitの履歴をグラフィカルに表示し、コミット間の差分を確認できる

require('gitgraph').setup({
  hooks = {
    -- 表示フォーマットの設定
    format = {
      timestamp = '%Y-%m-%d %H:%M:%S',  -- タイムスタンプのフォーマット
      -- 表示するフィールドの順序
      fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
    },
    -- 単一コミットを選択したときの動作
    on_select_commit = function(commit)
      vim.notify('DiffviewOpen ' .. commit.hash .. '^!')
      vim.cmd(':DiffviewOpen ' .. commit.hash .. '^!')
    end,
    -- コミット範囲を選択したときの動作（コミットAからコミットBまでの差分を表示）
    on_select_range_commit = function(from, to)
      vim.notify('DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
      vim.cmd(':DiffviewOpen ' .. from.hash .. '~1..' .. to.hash)
    end,
  },
  -- グラフ表示に使用する記号の設定
  symbols = {
    merge_commit = '○',      -- マージコミットを表す記号
    commit = '●',            -- 通常のコミットを表す記号
    merge_commit_end = '○',  -- マージコミットの終端記号
    commit_end = '●',        -- 通常のコミットの終端記号

    -- グラフ描画用の詳細な記号設定
    GVER = '│',
    GHOR = '─',
    GCLD = '╮',
    GCRD = '╭',
    GCLU = '╯',
    GCRU = '╰',
    GLRU = '┴',
    GLRD = '┬',
    GLUD = '┤',
    GRUD = '├',
    GFORKU = '┼',
    GFORKD = '┼',
    GRUDCD = '├',
    GRUDCU = '┡',
    GLUDCD = '┪',
    GLUDCU = '┩',
    GLRDCL = '┬',
    GLRDCR = '┬',
    GLRUCL = '┴',
    GLRUCR = '┴',
  },
})

-- キーマッピングの設定
-- Ctrl+g gでGitグラフを表示（最大5000コミットまで）
vim.keymap.set('n', '<C-g>g', function()
  require('gitgraph').draw({}, { all = true, max_count = 5000 })
end)
