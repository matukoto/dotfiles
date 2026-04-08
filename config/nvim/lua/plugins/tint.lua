return {
  'levouh/tint.nvim',
  event = 'VeryLazy',
  opts = {
    -- 暗くする度合い (-1.0 〜 1.0)
    -- 0.5 くらいが、文字が読める範囲でしっかり暗くなります
    tint = -45,
    -- 彩度を下げる度合い (0.0 〜 1.0)
    saturation = 0.5,
    -- 無視するフローティングウィンドウや特定のバッファを指定
    -- Noice や LspSaga のポップアップが暗くならないようにします
    filter = function(winid)
      local bufnr = vim.api.nvim_win_get_buf(winid)
      local ft = vim.bo[bufnr].filetype

      -- フローティングウィンドウは対象外にする
      if vim.api.nvim_win_get_config(winid).relative ~= '' then
        return true
      end

      -- 特定のファイルタイプを除外
      local ignore_ft = { 'fern', 'NvimTree', 'noice', 'notify' }
      if vim.tbl_contains(ignore_ft, ft) then
        return true
      end

      return false
    end,
  },
}
