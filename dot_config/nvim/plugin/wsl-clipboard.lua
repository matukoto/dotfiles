if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'xsel -bi',
      ['*'] = 'xsel -bi',
    },
    paste = {
      ['+'] = 'xsel -bo',
      ['*'] = function()
        return vim.fn.systemlist('xsel -bo | tr -d "\r"')
      end,
    },
    cache_enabled = 1,
  }
  -- vim.g.clipboard = {
  --   name = 'WslClipboard',
  --   copy = {
  --     ['+'] = 'xclip -selection clipboard',
  --     ['*'] = 'xclip -selection clipboard',
  --   },
  --   paste = {

  -- Windows クリップボードと連携できない
  -- \r が消える
  -- -- Vim のコピーで改行は消えない
  -- ['+'] = 'xclip -selection clipboard -o | tr -d "\r"',
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,

  -- Windows クリップボードと連携できる
  -- \r が消える
  -- -- Vim のコピーでも改行が消えちゃう
  -- ['+'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,

  -- Windows クリップボードと連携できる
  -- \r が消えない
  -- -- Vim のコピーでも改行が消えちゃう
  -- ['+'] = function() return vim.fn.systemlist('xclip -selection clipboard -o') end,
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o | tr -d "\r"') end,

  -- Windows クリップボードと連携できる
  -- \r が消えない
  -- Vim のコピーでも改行が消えちゃう
  -- ['+'] = function() return vim.fn.systemlist('xclip -selection clipboard -o') end,
  -- ['*'] = function() return vim.fn.systemlist('xclip -selection clipboard -o') end,

  -- Windows クリップボードと連携できない
  --['+'] = function() return vim.fn.systemList('xclip -selection clipboard -o | tr -d "\r"') end,
  --['*'] = function() return vim.fn.systemList('xclip -selection clipboard -o | tr -d "\r"') end,
  --   },
  --   cache_enabled = 1,
  -- }
end
