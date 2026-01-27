return {
  -- Edge: 基本これ。高コントラストでネオン調のテーマ
  {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
      -- Edge: 高コントラストでネオン調のテーマ。
      vim.g.edge_enable_italic = true
      vim.g.edge_style = 'neon' -- neon, aura, default
      vim.g.edge_dim_inactive_windows = true
      vim.cmd.colorscheme('edge')
    end,
  },
  -- Gruvbox-material: 伝統的な低彩度の暖色系ダークテーマ
  -- {
  --   'sainnhe/gruvbox-material',
  --   priority = 1000,
  --   enabled = true,
  --   config = function()
  --    vim.cmd.colorscheme('gruvbox')
  --   end,
  -- },
  -- Sonokai: 柔らかいコントラストのダークテーマ
  -- {
  --   'sainnhe/sonokai',
  --   priority = 1000,
  --   enabled = true,
  --   config = function()
  --   end,
  -- },
  -- ==========================================
  -- ライトテーマ: everforest
  -- ==========================================
  -- {
  --   'sainnhe/everforest',
  --   priority = 1000,
  --   enabled = true,
  --   config = function()
  --     vim.opt.background = 'light'
  --     vim.g.everforest_background = 'soft'
  --     vim.cmd.colorscheme('everforest')
  --   end,
  -- },
  -- ==========================================
  -- Rose Pine (くすみカラー・上品な暖色)
  -- ==========================================
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
  -- ==========================================
  -- Tokyo Night (モダン・寒色系)
  -- ==========================================
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
  -- ==========================================
  -- Catppuccin (パステル・高い視認性)
  -- ==========================================
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
  -- ==========================================
  -- Kanagawa (和風・落ち着いた中間色)
  -- ==========================================
  -- {
  --   'rebelot/kanagawa.nvim',
  --   priority = 1000,
  --   enabled = false,
  --   config = function()
  --     vim.cmd([[colorscheme kanagawa]])
  --   end,
  -- },
}
