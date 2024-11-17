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
  console.log("Added vim-jp/vimdoc-ja");

  await dvpm.add({ url: "nvim-lua/plenary.nvim" });
  console.log("Added nvim-lua/plenary.nvim");

  await dvpm.add({ url: "kkharji/sqlite.lua" });
  console.log("Added kkharji/sqlite.lua");

  await dvpm.add({ url: "danielfalk/smart-open.nvim" });
  console.log("Added danielfalk/smart-open.nvim");

  await dvpm.add({ url: "atusy/qfscope.nvim" });
  console.log("Added atusy/qfscope.nvim");

  await dvpm.add({ url: "cljoly/telescope-repo.nvim" });
  console.log("Added cljoly/telescope-repo.nvim");

  await dvpm.add({ url: "williamboman/mason.nvim" });
  console.log("Added williamboman/mason.nvim");

  await dvpm.add({ url: "williamboman/mason-lspconfig.nvim" });
  console.log("Added williamboman/mason-lspconfig.nvim");

  await dvpm.add({ url: "WhoIsSethDaniel/mason-tool-installer.nvim" });
  console.log("Added WhoIsSethDaniel/mason-tool-installer.nvim");

  await dvpm.add({ url: "nvim-java/lua-async-await" });
  console.log("Added nvim-java/lua-async-await");

  await dvpm.add({ url: "nvim-java/nvim-java-refactor" });
  console.log("Added nvim-java/nvim-java-refactor");

  await dvpm.add({ url: "nvim-java/nvim-java-core" });
  console.log("Added nvim-java/nvim-java-core");

  await dvpm.add({ url: "nvim-java/nvim-java-test" });
  console.log("Added nvim-java/nvim-java-test");

  await dvpm.add({ url: "nvim-java/nvim-java-dap" });
  console.log("Added nvim-java/nvim-java-dap");

  await dvpm.add({ url: "MunifTanjim/nui.nvim" });
  console.log("Added MunifTanjim/nui.nvim");

  await dvpm.add({ url: "mfussenegger/nvim-dap" });
  console.log("Added mfussenegger/nvim-dap");

  await dvpm.add({ url: "JavaHello/spring-boot.nvim" });
  console.log("Added JavaHello/spring-boot.nvim");

  await dvpm.add({ url: "nanotee/sqls.nvim" });
  console.log("Added nanotee/sqls.nvim");

  await dvpm.add({ url: "shougo/ddc-matcher_head" });
  console.log("Added shougo/ddc-matcher_head");

  await dvpm.add({ url: "shougo/ddc-sorter_rank" });
  console.log("Added shougo/ddc-sorter_rank");

  await dvpm.add({ url: "tani/ddc-fuzzy" });
  console.log("Added tani/ddc-fuzzy");

  await dvpm.add({ url: "shougo/ddc-ui-pum" });
  console.log("Added shougo/ddc-ui-pum");

  await dvpm.add({ url: "shougo/pum.vim" });
  console.log("Added shougo/pum.vim");

  await dvpm.add({ url: "shougo/ddc-source-lsp" });
  console.log("Added shougo/ddc-source-lsp");

  await dvpm.add({ url: "shougo/ddc-source-around" });
  console.log("Added shougo/ddc-source-around");

  await dvpm.add({ url: "LumaKernel/ddc-source-file" });
  console.log("Added LumaKernel/ddc-source-file");

  await dvpm.add({ url: "matsui54/ddc-source-buffer" });
  console.log("Added matsui54/ddc-source-buffer");

  await dvpm.add({ url: "uga-rosa/ddc-source-nvim-lua" });
  console.log("Added uga-rosa/ddc-source-nvim-lua");

  await dvpm.add({ url: "shougo/ddc-source-cmdline" });
  console.log("Added shougo/ddc-source-cmdline");

  await dvpm.add({ url: "shougo/ddc-source-cmdline-history" });
  console.log("Added shougo/ddc-source-cmdline-history");

  await dvpm.add({ url: "matsui54/denops-popup-preview.vim" });
  console.log("Added matsui54/denops-popup-preview.vim");

  await dvpm.add({ url: "matsui54/denops-signature_help" });
  console.log("Added matsui54/denops-signature_help");

  await dvpm.add({
    url: "yuki-yano/fern-preview.vim",
    dependencies: ["lambdalisue/vim-fern"],
  });
  console.log("Added yuki-yano/fern-preview.vim");

  await dvpm.add({ url: "lambdalisue/vim-fern-git-status" });
  console.log("Added lambdalisue/vim-fern-git-status");

  await dvpm.add({ url: "lambdalisue/vim-fern-hijack" });
  console.log("Added lambdalisue/vim-fern-hijack");

  await dvpm.add({ url: "lambdalisue/vim-nerdfont" });
  console.log("Added lambdalisue/vim-nerdfont");

  await dvpm.add({
    url: "mikavilpas/yazi.nvim",
    afterFile: "~/.config/nvim/plugin.d/yazi.lua",
  });
  console.log("Added mikavilpas/yazi.nvim");

  await dvpm.add({ url: "sainnhe/gruvbox-material" });
  console.log("Added sainnhe/gruvbox-material");

  await dvpm.add({ url: "sainnhe/edge" });
  console.log("Added sainnhe/edge");

  await dvpm.add({ url: "sainnhe/sonokai" });
  console.log("Added sainnhe/sonokai");

  await dvpm.add({ url: "sainnhe/everforest" });
  console.log("Added sainnhe/everforest");

  await dvpm.add({ url: "edeneast/nightfox.nvim" });
  console.log("Added edeneast/nightfox.nvim");

  await dvpm.add({ url: "AlexvZyl/nordic.nvim" });
  console.log("Added AlexvZyl/nordic.nvim");

  await dvpm.add({ url: "folke/tokyonight.nvim" });
  console.log("Added folke/tokyonight.nvim");

  await dvpm.add({ url: "tanvirtin/monokai.nvim" });
  console.log("Added tanvirtin/monokai.nvim");

  await dvpm.add({ url: "hachy/eva01.vim" });
  console.log("Added hachy/eva01.vim");

  await dvpm.add({ url: "antoinemadec/FixCursorHold.nvim" });
  await dvpm.add({ url: "marilari88/neotest-vitest" });
  await dvpm.add({ url: "nvim-neotest/nvim-nio" });

  // neotest
  await dvpm.add({
    url: "nvim-neotest/neotest",
    dependencies: [
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
    ],
    afterFile: "~/.config/nvim/plugin.d/neotest.lua",
  });
  console.log("Added neotest");

  await dvpm.add({ url: "haya14busa/vim-asterisk" });
  console.log("Added haya14busa/vim-asterisk");

  await dvpm.add({
    url: "0xAdk/full_visual_line.nvim",
    after: async ({ denops }) => {
      await denops.call(`luaeval`, `require('full_visual_line').setup()`);
    },
  });
  console.log("Added 0xAdk/full_visual_line.nvim");

  await dvpm.add({ url: "kevinhwang91/promise-async" });
  console.log("Added kevinhwang91/promise-async");

  await dvpm.add({
    url: "kevinhwang91/nvim-ufo",
    dependencies: [
      "nvim-treesitter/nvim-treesitter",
      "kevinhwang91/promise-async",
    ],
    afterFile: "~/.config/nvim/plugin.d/ufo.lua",
  });
  console.log("Added kevinhwang91/nvim-ufo");

  await dvpm.add({
    url: "mattn/vim-sonictemplate",
    afterFile: "~/.config/nvim/plugin.d/vim-sonictemplate.vim",
  });
  console.log("Added mattn/vim-sonictemplate");

  await dvpm.add({
    url: "thinca/vim-quickrun",
    after: async ({ denops }) =>
      await execute(denops, `cabbrev qr QuickRun<CR>`),
  });
  console.log("Added thinca/vim-quickrun");

  await dvpm.add({
    url: "numToStr/comment.nvim",
    afterFile: "~/.config/nvim/plugin.d/comment.lua",
  });
  console.log("Added numToStr/comment.nvim");

  await dvpm.add({
    url: "folke/todo-comments.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require('todo-comments').setup()`,
      );
    },
  });
  console.log("Added folke/todo-comments.nvim");

  await dvpm.add({
    url: "yuki-yano/fuzzy-motion.vim",
    afterFile: "~/.config/nvim/plugin.d/fuzzy-motion.vim",
  });
  console.log("Added yuki-yano/fuzzy-motion.vim");

  await dvpm.add({
    url: "ethanholz/nvim-lastplace",
    afterFile: "~/.config/nvim/plugin.d/nvim-lastplace.lua",
  });
  console.log("Added ethanholz/nvim-lastplace");

  await dvpm.add({
    url: "haya14busa/vim-edgemotion",
    afterFile: "~/.config/nvim/plugin.d/vim-edgemotion.vim",
  });
  console.log("Added haya14busa/vim-edgemotion");

  await dvpm.add({
    url: "shellRaining/hlchunk.nvim",
    afterFile: "~/.config/nvim/plugin.d/hlchunk.lua",
  });
  console.log("Added shellRaining/hlchunk.nvim");

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
  console.log("Added uga-rosa/ddc-source-lsp-setup");

  await dvpm.add({
    url: "nvimdev/lspsaga.nvim",
    afterFile: "~/.config/nvim/plugin.d/lspsaga.lua",
  });
  console.log("Added nvimdev/lspsaga.nvim");

  await dvpm.add({
    url: "j-hui/fidget.nvim",
    afterFile: "~/.config/nvim/plugin.d/fidget.lua",
  });
  console.log("Added j-hui/fidget.nvim");

  await dvpm.add({
    url: "neovim/nvim-lspconfig",
    dependencies: [
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "nvimdev/lspsaga.nvim",
      "nanotee/sqls.nvim",
    ],
    afterFile: "~/.config/nvim/plugin.d/lspconfig.lua",
  });
  console.log("Added neovim/nvim-lspconfig");

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
      "JavaHello/spring-boot.nvim",
      "neovim/nvim-lspconfig",
    ],
    afterFile: "~/.config/nvim/plugin.d/jdtls.lua",
  });
  console.log("Added nvim-java/nvim-java");

  await dvpm.add({
    url: "stevearc/conform.nvim",
    dependencies: ["williamboman/mason.nvim"],
    afterFile: "~/.config/nvim/plugin.d/conform.lua",
  });
  console.log("Added stevearc/conform.nvim");

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
  console.log("Added shougo/ddc.vim");

  await dvpm.add({
    url: "lambdalisue/vim-fern",
    dependencies: [
      "lambdalisue/vim-fern-git-status",
    ],
    afterFile: "~/.config/nvim/plugin.d/fern.vim",
  });
  console.log("Added lambdalisue/vim-fern");

  await dvpm.add({
    url: "lambdalisue/vim-fern-renderer-nerdfont",
    dependencies: ["lambdalisue/vim-nerdfont"],
    after: async ({ denops }) =>
      await execute(denops, `let g:fern#renderer = "nerdfont"`),
  });
  console.log("Added lambdalisue/vim-fern-renderer-nerdfont");

  await dvpm.add({
    url: "stevearc/oil.nvim",
    dependencies: ["nvim-tree/nvim-web-devicons"],
    afterFile: "~/.config/nvim/plugin.d/oil.lua",
  });
  console.log("Added stevearc/oil.nvim");

  await dvpm.add({
    url: "nvim-lualine/lualine.nvim",
    dependencies: ["nvim-tree/nvim-web-devicons"],
    afterFile: "~/.config/nvim/plugin.d/lualine.lua",
  });
  console.log("Added nvim-lualine/lualine.nvim");

  await dvpm.add({ url: "nvim-tree/nvim-web-devicons" });
  console.log("Added nvim-tree/nvim-web-devicons");

  await dvpm.add({
    url: "chomosuke/term-edit.nvim",
    after: async ({ denops }) => {
      await denops.call(
        `luaeval`,
        `require('term-edit').setup({  prompt_end = '%$ ',})`,
      );
    },
  });
  console.log("Added chomosuke/term-edit.nvim");

  await dvpm.add({
    url: "akinsho/toggleterm.nvim",
    afterFile: "~/.config/nvim/plugin.d/toggleterm.lua",
  });
  console.log("Added akinsho/toggleterm.nvim");

  await dvpm.add({
    url: "nvim-treesitter/nvim-treesitter",
    dependencies: ["nvim-treesitter/nvim-treesitter-context"],
    afterFile: "~/.config/nvim/plugin.d/nvim-treesitter.lua",
  });
  console.log("Added nvim-treesitter/nvim-treesitter");

  await dvpm.add({ url: "nvim-treesitter/nvim-treesitter-context" });
  console.log("Added nvim-treesitter/nvim-treesitter-context");

  await dvpm.add({
    url: "lambdalisue/vim-gin",
    afterFile: "~/.config/nvim/plugin.d/gin.vim",
  });
  console.log("Added lambdalisue/vim-gin");

  await dvpm.add({ url: "ogaken-1/nvim-gin-preview" });
  console.log("Added ogaken-1/nvim-gin-preview");

  await dvpm.add({
    url: "lewis6991/gitsigns.nvim",
    afterFile: "~/.config/nvim/plugin.d/gitsigns.lua",
  });
  console.log("Added lewis6991/gitsigns.nvim");

  await dvpm.add({
    url: "isakbm/gitgraph.nvim",
    dependencies: ["sindrets/diffview.nvim"],
    afterFile: "~/.config/nvim/plugin.d/gitgraph.lua",
  });
  console.log("Added isakbm/gitgraph.nvim");

  await dvpm.add({ url: "sindrets/diffview.nvim" });
  console.log("Added sindrets/diffview.nvim");

  await dvpm.add({ url: "lambdalisue/vim-kensaku" });
  console.log("Added lambdalisue/vim-kensaku");

  await dvpm.add({ url: "lambdalisue/vim-kensaku-search" });
  console.log("Added lambdalisue/vim-kensaku-search");

  await dvpm.add({
    url: "vim-skk/skkeleton",
    afterFile: "~/.config/nvim/plugin.d/vim-skkeleton.vim",
  });
  console.log("Added vim-skk/skkeleton");

  await dvpm.add({
    url: "NI57721/skkeleton-state-popup",
    dependencies: ["vim-skk/skkeleton"],
    afterFile: "~/.config/nvim/plugin.d/skkeleton_state_popup.vim",
  });
  console.log("Added NI57721/skkeleton-state-popup");

  await dvpm.add({
    url: "nvim-telescope/telescope.nvim",
    dependencies: [
      "danielfalk/smart-open.nvim",
      "kkharji/sqlite.lua",
      "danielfalk/smart-open.nvim",
      "cljoly/telescope-repo.nvim",
    ],
  });
  console.log("Added nvim-telescope/telescope.nvim");

  await dvpm.add({
    url: "prochri/telescope-all-recent.nvim",
    dependencies: [
      "nvim-telescope/telescope.nvim",
      "atusy/qfscope.nvim",
      "nvim-lua/plenary.nvim",
    ],
    afterFile: "~/.config/nvim/plugin.d/telescope.lua",
  });
  console.log("Added prochri/telescope-all-recent.nvim");

  await dvpm.add({ url: "kevinhwang91/nvim-bqf" });
  console.log("Added kevinhwang91/nvim-bqf");

  // await dvpm.add({
  //   url: "folke/which-key.nvim",
  //   afterFile: "~/.config/nvim/plugin.d/which-key.lua",
  //  enabled: false,
  // });

  await dvpm.add({
    url: "stevearc/aerial.nvim",
    dependencies: ["nvim-treesitter/nvim-treesitter"],
    afterFile: "~/.config/nvim/plugin.d/aerial.lua",
  });
  console.log("Added stevearc/aerial.nvim");

  await dvpm.add({
    url: "kevinhwang91/nvim-hlslens",
    afterFile: "~/.config/nvim/plugin.d/hlslens.lua",
  });
  console.log("Added kevinhwang91/nvim-hlslens");

  await dvpm.add({
    url: "https://github.com/github/copilot.vim",
    afterFile: "~/.config/nvim/plugin.d/copilot.vim",
  });
  console.log("Added github/copilot.vim");
  await dvpm.add({
    url: "CopilotC-Nvim/CopilotChat.nvim",
    dependencies: [
      "https://github.com/github/copilot.vim",
      "nvim-lua/plenary.nvim",
    ],
    afterFile: "~/.config/nvim/plugin.d/CopilotChat.lua",
  });
  console.log("Added CopilotC-Nvim/CopilotChat.nvim");
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
  await dvpm.add({ url: "wakatime/vim-wakatime" });

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
