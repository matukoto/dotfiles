import type { Denops } from "jsr:@denops/std";
import * as fn from "jsr:@denops/std/function";
import { ensure, is } from "jsr:@core/unknownutil";
import { execute } from "jsr:@denops/std/helper";

import { Dvpm } from "jsr:@yukimemi/dvpm";

export async function main(denops: Denops): Promise<void> {
  const base_path = (await fn.has(denops, "nvim"))
    ? "~/.cache/nvim/dvpm"
    : "~/.cache/vim/dvpm";
  const base = ensure(await fn.expand(denops, base_path), is.String);

  // First, call Dvpm.begin with denops object and base path.
  const dvpm = await Dvpm.begin(denops, { base });

  await dvpm.add({ url: "vim-jp/vimdoc-ja" });

  await dvpm.add({ url: "nvim-lua/plenary.nvim", enabled: true });

  // await dvpm.add({ url: "kkharji/sqlite.lua", enabled: true });

  // await dvpm.add({ url: "danielfalk/smart-open.nvim", enabled: true });

  // await dvpm.add({ url: "atusy/qfscope.nvim", enabled: true });

  await dvpm.add({
    url: "vim-skk/skkeleton",
    afterFile: "~/.config/nvim/plugin.d/vim-skkeleton.vim",
  });

  // await dvpm.add({ url: "cljoly/telescope-repo.nvim", enabled: true });

  await dvpm.add({ url: "williamboman/mason.nvim" });

  await dvpm.add({ url: "williamboman/mason-lspconfig.nvim" });

  await dvpm.add({ url: "WhoIsSethDaniel/mason-tool-installer.nvim" });

  await dvpm.add({ url: "nvim-java/lua-async-await" });

  await dvpm.add({ url: "nvim-java/nvim-java-refactor" });

  await dvpm.add({ url: "nvim-java/nvim-java-core" });

  await dvpm.add({ url: "nvim-java/nvim-java-test" });

  await dvpm.add({ url: "nvim-java/nvim-java-dap" });

  await dvpm.add({ url: "MunifTanjim/nui.nvim" });

  await dvpm.add({ url: "mfussenegger/nvim-dap" });

  await dvpm.add({ url: "nanotee/sqls.nvim" });

  await dvpm.add({ url: "shougo/ddc-matcher_head" });

  await dvpm.add({ url: "shougo/ddc-sorter_rank" });

  await dvpm.add({ url: "tani/ddc-fuzzy" });

  await dvpm.add({ url: "shougo/ddc-ui-pum" });

  await dvpm.add({ url: "shougo/pum.vim" });

  await dvpm.add({ url: "shougo/ddc-source-lsp" });

  await dvpm.add({ url: "shougo/ddc-source-around" });

  await dvpm.add({ url: "LumaKernel/ddc-source-file" });

  await dvpm.add({ url: "matsui54/ddc-source-buffer" });

  await dvpm.add({ url: "uga-rosa/ddc-source-nvim-lua" });

  await dvpm.add({ url: "shougo/ddc-source-cmdline" });

  await dvpm.add({ url: "shougo/ddc-source-cmdline-history" });

  await dvpm.add({ url: "matsui54/denops-popup-preview.vim" });

  await dvpm.add({ url: "matsui54/denops-signature_help" });
  await dvpm.add({ url: "lambdalisue/vim-fern-git-status" });

  await dvpm.add({ url: "lambdalisue/vim-fern-hijack" });
  await dvpm.add({
    url: "uga-rosa/ccc.nvim",
    afterFile: "~/.config/nvim/plugin.d/ccc.lua",
  });

  await dvpm.add({ url: "lambdalisue/vim-nerdfont" });

  await dvpm.add({
    url: "mikavilpas/yazi.nvim",
    dependencies: ["nvim-lua/plenary.nvim"],
    afterFile: "~/.config/nvim/plugin.d/yazi.lua",
  });

  await dvpm.add({ url: "sainnhe/gruvbox-material" });

  await dvpm.add({ url: "sainnhe/edge" });

  await dvpm.add({ url: "sainnhe/sonokai" });

  await dvpm.add({ url: "sainnhe/everforest" });

  await dvpm.add({ url: "edeneast/nightfox.nvim" });

  await dvpm.add({ url: "AlexvZyl/nordic.nvim" });

  await dvpm.add({ url: "folke/tokyonight.nvim" });

  await dvpm.add({ url: "tanvirtin/monokai.nvim" });

  await dvpm.add({ url: "hachy/eva01.vim" });

  // neotest
  await dvpm.add({ url: "antoinemadec/FixCursorHold.nvim" });
  await dvpm.add({ url: "marilari88/neotest-vitest" });
  await dvpm.add({ url: "nvim-neotest/nvim-nio" });
  await dvpm.add({ url: "mfussenegger/nvim-jdtls" });
  await dvpm.add({ url: "theHamsta/nvim-dap-virtual-text" });
  await dvpm.add({ url: "rcarriga/nvim-dap-ui" });

  await dvpm.add({
    url: "nvim-neotest/neotest",
    dependencies: [
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
    ],
  });

  await dvpm.add({
    url: "rcasia/neotest-java",
    dependencies: [
      "mfussenegger/nvim-jdtls",
      "nvim-java/nvim-java",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/neotest",
    ],
    afterFile: "~/.config/nvim/plugin.d/neotest.lua",
  });

  await dvpm.add({ url: "haya14busa/vim-asterisk" });

  await dvpm.add({
    url: "0xAdk/full_visual_line.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('full_visual_line').setup()`);
    },
  });

  await dvpm.add({ url: "kevinhwang91/promise-async" });

  await dvpm.add({
    url: "mattn/vim-sonictemplate",
    afterFile: "~/.config/nvim/plugin.d/vim-sonictemplate.vim",
  });

  await dvpm.add({
    url: "thinca/vim-quickrun",
    after: async ({ denops }) =>
      await execute(denops, `cabbrev qr QuickRun<CR>`),
  });

  await dvpm.add({
    url: "numToStr/comment.nvim",
    afterFile: "~/.config/nvim/plugin.d/comment.lua",
  });

  await dvpm.add({
    url: "folke/todo-comments.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require('todo-comments').setup()`,
      );
    },
  });

  await dvpm.add({
    url: "yuki-yano/fuzzy-motion.vim",
    afterFile: "~/.config/nvim/plugin.d/fuzzy-motion.vim",
  });

  await dvpm.add({
    url: "ethanholz/nvim-lastplace",
    afterFile: "~/.config/nvim/plugin.d/nvim-lastplace.lua",
  });

  await dvpm.add({
    url: "haya14busa/vim-edgemotion",
    afterFile: "~/.config/nvim/plugin.d/vim-edgemotion.vim",
  });

  await dvpm.add({
    url: "shellRaining/hlchunk.nvim",
    afterFile: "~/.config/nvim/plugin.d/hlchunk.lua",
  });

  await dvpm.add({
    url: "nvimdev/lspsaga.nvim",
    afterFile: "~/.config/nvim/plugin.d/lspsaga.lua",
  });

  await dvpm.add({
    url: "j-hui/fidget.nvim",
    afterFile: "~/.config/nvim/plugin.d/fidget.lua",
  });

  await dvpm.add({
    url: "neovim/nvim-lspconfig",
    dependencies: [
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "nanotee/sqls.nvim",
    ],
    afterFile: "~/.config/nvim/plugin.d/lspconfig.lua",
  });

  await dvpm.add({
    url: "uga-rosa/ddc-source-lsp-setup",
    dependencies: ["neovim/nvim-lspconfig"],
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require('ddc_source_lsp_setup').setup()`,
      );
    },
  });

  await dvpm.add({
    url: "nvim-java/nvim-java",
    dependencies: [
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-refactor",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
    ],
    afterFile: "~/.config/nvim/plugin.d/jdtls.lua",
  });

  await dvpm.add({
    url: "stevearc/conform.nvim",
    dependencies: ["williamboman/mason.nvim"],
    afterFile: "~/.config/nvim/plugin.d/conform.lua",
  });

  await dvpm.add({
    url: "shougo/ddc.vim",
    dependencies: [
      "shougo/ddc-sorter_rank",
      "tani/ddc-fuzzy",
      "shougo/ddc-ui-pum",
      "shougo/pum.vim",
      "shougo/ddc-source-lsp",
      "shougo/ddc-source-around",
      "LumaKernel/ddc-source-file",
      "uga-rosa/ddc-source-lsp-setup",
      "matsui54/ddc-source-buffer",
      "uga-rosa/ddc-source-nvim-lua",
      "shougo/ddc-source-cmdline",
      "shougo/ddc-source-cmdline-history",
      "vim-skk/skkeleton",
    ],
    afterFile: "~/.config/nvim/plugin.d/ddc.vim",
  });

  await dvpm.add({
    url: "lambdalisue/vim-fern",
    dependencies: [
      "lambdalisue/vim-fern-git-status",
    ],
    afterFile: "~/.config/nvim/plugin.d/fern.vim",
  });

  await dvpm.add({
    url: "yuki-yano/fern-preview.vim",
    dependencies: ["lambdalisue/vim-fern"],
  });

  await dvpm.add({
    url: "lambdalisue/vim-fern-renderer-nerdfont",
    dependencies: ["lambdalisue/vim-nerdfont"],
    after: async ({ denops }) =>
      await execute(denops, `let g:fern#renderer = "nerdfont"`),
  });
  await dvpm.add({ url: "nvim-tree/nvim-web-devicons" });

  await dvpm.add({
    url: "stevearc/oil.nvim",
    dependencies: ["nvim-tree/nvim-web-devicons"],
    afterFile: "~/.config/nvim/plugin.d/oil.lua",
  });

  await dvpm.add({
    url: "nvim-lualine/lualine.nvim",
    dependencies: ["nvim-tree/nvim-web-devicons"],
    afterFile: "~/.config/nvim/plugin.d/lualine.lua",
  });

  await dvpm.add({
    url: "chomosuke/term-edit.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require('term-edit').setup({  prompt_end = '%$ ',})`,
      );
    },
  });

  await dvpm.add({
    url: "akinsho/toggleterm.nvim",
    afterFile: "~/.config/nvim/plugin.d/toggleterm.lua",
  });

  await dvpm.add({ url: "nvim-treesitter/nvim-treesitter-context" });
  await dvpm.add({
    url: "nvim-treesitter/nvim-treesitter",
    dependencies: ["nvim-treesitter/nvim-treesitter-context"],
    afterFile: "~/.config/nvim/plugin.d/nvim-treesitter.lua",
  });

  await dvpm.add({
    url: "lambdalisue/vim-gin",
    afterFile: "~/.config/nvim/plugin.d/gin.vim",
  });

  await dvpm.add({ url: "ogaken-1/nvim-gin-preview" });

  await dvpm.add({
    url: "lewis6991/gitsigns.nvim",
    afterFile: "~/.config/nvim/plugin.d/gitsigns.lua",
  });

  await dvpm.add({ url: "sindrets/diffview.nvim" });

  await dvpm.add({
    url: "isakbm/gitgraph.nvim",
    dependencies: ["sindrets/diffview.nvim"],
    afterFile: "~/.config/nvim/plugin.d/gitgraph.lua",
  });

  await dvpm.add({ url: "lambdalisue/vim-kensaku" });

  await dvpm.add({ url: "lambdalisue/vim-kensaku-search" });

  await dvpm.add({
    url: "NI57721/skkeleton-state-popup",
    // dependencies: ["vim-skk/skkeleton"],
    afterFile: "~/.config/nvim/plugin.d/skkeleton_state_popup.vim",
  });

  // await dvpm.add({
  //   url: "nvim-telescope/telescope.nvim",
  //   dependencies: [
  //     "kkharji/sqlite.lua",
  //     "danielfalk/smart-open.nvim",
  //     "cljoly/telescope-repo.nvim",
  //   ],
  //   enabled: true,
  // });

  // await dvpm.add({
  //   url: "prochri/telescope-all-recent.nvim",
  //   dependencies: [
  //     "nvim-telescope/telescope.nvim",
  //     "atusy/qfscope.nvim",
  //     "nvim-lua/plenary.nvim",
  //   ],
  //   enabled: true,
  //   afterFile: "~/.config/nvim/plugin.d/telescope.lua",
  // });

  await dvpm.add({ url: "kevinhwang91/nvim-bqf" });

  await dvpm.add({
    url: "folke/which-key.nvim",
    afterFile: "~/.config/nvim/plugin.d/which-key.lua",
    enabled: true,
  });

  await dvpm.add({
    url: "stevearc/aerial.nvim",
    dependencies: ["nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/plugin.d/aerial.lua",
  });

  await dvpm.add({
    url: "kevinhwang91/nvim-ufo",
    dependencies: [
      "nvim-treesitter/nvim-treesitter",
      "kevinhwang91/promise-async",
    ],
    afterFile: "~/.config/nvim/plugin.d/ufo.lua",
  });

  await dvpm.add({
    url: "kevinhwang91/nvim-hlslens",
    afterFile: "~/.config/nvim/plugin.d/hlslens.lua",
  });

  await dvpm.add({
    url: "https://github.com/github/copilot.vim",
    afterFile: "~/.config/nvim/plugin.d/copilot.vim",
    enabled: false,
  });
  await dvpm.add({
    url: "CopilotC-Nvim/CopilotChat.nvim",
    dependencies: [
      "https://github.com/github/copilot.vim",
      "nvim-lua/plenary.nvim",
    ],
    afterFile: "~/.config/nvim/plugin.d/CopilotChat.lua",
  });
  await dvpm.add({ url: "tyru/capture.vim" });
  await dvpm.add({ url: "itchyny/vim-cursorword" });
  await dvpm.add({ url: "tyru/open-browser.vim" });
  await dvpm.add({ url: "lambdalisue/vim-guise" });
  await dvpm.add({ url: "lambdalisue/vim-suda" });
  await dvpm.add({
    url: "johann2357/nvim-smartbufs",
    afterFile: "~/.config/nvim/plugin.d/smartbufs.lua",
  });
  await dvpm.add({ url: "mechatroner/rainbow_csv" });
  await dvpm.add({
    url: "tkmpypy/chowcho.nvim",
    afterFile: "~/.config/nvim/plugin.d/chowcho.lua",
  });
  await dvpm.add({
    url: "folke/styler.nvim",
    dependencies: ["edeneast/nightfox.nvim"],
    afterFile: "~/.config/nvim/plugin.d/styler.lua",
  });
  await dvpm.add({
    url: "ahmedkhalf/project.nvim",
    afterFile: "~/.config/nvim/plugin.d/project.lua",
  });
  await dvpm.add({
    url: "MeanderingProgrammer/markdown.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('render-markdown').setup()`);
    },
  });
  await dvpm.add({
    url: "monaqa/dial.nvim",
    afterFile: "~/.config/nvim/plugin.d/dial.lua",
  });
  await dvpm.add({ url: "tani/dmacro.nvim" });
  await dvpm.add({ url: "famiu/bufdelete.nvim" });
  await dvpm.add({ url: "simeji/winresizer" });
  //キャメルケース単位でのオブジェクト指定
  await dvpm.add({
    url: "bkad/CamelCaseMotion",
    afterFile: "~/.config/nvim/plugin.d/CamelCaseMotion.vim",
  });
  //閉じ括弧の自動挿入
  await dvpm.add({
    url: "cohama/lexima.vim",
    afterFile: "~/.config/nvim/plugin.d/lexima.vim",
  });
  //閉じタグの自動挿入
  await dvpm.add({
    url: "windwp/nvim-ts-autotag",
    afterFile: "~/.config/nvim/plugin.d/nvim-ts-autotag.lua",
  });
  //"(などで囲える
  await dvpm.add({ url: "tpope/vim-surround" });
  await dvpm.add({
    url: "matukoto/fm-nvim",
    afterFile: "~/.config/nvim/plugin.d/fm-nvim.lua",
  });
  //easymotion
  await dvpm.add({
    url: "folke/flash.nvim",
    afterFile: "~/.config/nvim/plugin.d/flash.lua",
  });
  await dvpm.add({ url: "machakann/vim-sandwich" });
  //WakaTime コーディング時間を計測してくれる
  await dvpm.add({ url: "wakatime/vim-wakatime", enabled: false });

  //DB
  await dvpm.add({ url: "tpope/vim-dadbod" });
  await dvpm.add({
    url: "kristijanhusak/vim-dadbod-ui",
    dependencies: ["tpope/vim-dadbod"],
    afterFile: "~/.config/nvim/plugin.d/vim-dadbod.vim",
  });

  //カラースキーマ
  await dvpm.add({
    url: "gen740/SmoothCursor.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('smoothcursor').setup()`);
    },
  });

  await dvpm.end();

  console.log("Load completed !");
}