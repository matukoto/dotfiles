return {
  -- ==========================================
  -- 1. Gruvbox (レトロ・暖色系)
  -- ==========================================
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    enabled = true, -- これを true にして使用
    config = function()
      require('gruvbox').setup({
        contrast = 'hard', -- soft, medium, hard から選択
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  -- -- ==========================================
  -- -- 2. Rose Pine (くすみカラー・上品な暖色)
  -- -- ==========================================
  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     vim.cmd([[colorscheme rose-pine]])
  --   end,
  -- },
  --
  -- -- ==========================================
  -- -- 3. Tokyo Night (モダン・寒色系)
  -- -- ==========================================
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     require('tokyonight').setup({ style = 'moon' })
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },
  --
  -- -- ==========================================
  -- -- 4. Catppuccin (パステル・高い視認性)
  -- -- ==========================================
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     vim.cmd([[colorscheme catppuccin-mocha]])
  --   end,
  -- },
  --
  -- -- ==========================================
  -- -- 5. Kanagawa (和風・落ち着いた中間色)
  -- -- ==========================================
  -- {
  --   'rebelot/kanagawa.nvim',
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     vim.cmd([[colorscheme kanagawa]])
  --   end,
  -- },
}
