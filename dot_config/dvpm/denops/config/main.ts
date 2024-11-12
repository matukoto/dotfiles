import type { Denops } from "jsr:@denops/std";
import * as fn from "jsr:@denops/std/function";
import { ensure, is } from "jsr:@core/unknownutil";

import { Dvpm } from "jsr:@yukimemi/dvpm";

export async function main(denops: Denops): Promise<void> {
  const base_path = (await fn.has(denops, "nvim"))
    ? "~/.cache/nvim/dvpm"
    : "~/.cache/vim/dvpm";
  const base = ensure(await fn.expand(denops, base_path), is.String);

  // First, call Dvpm.begin with denops object and base path.
  const dvpm = await Dvpm.begin(denops, { base });

  await dvpm.add({ url: "vim-jp/vimdoc-ja" });

  //systemd 使えないとだめなので wsl ではコメントアウト
  //await dvpm.add({ url: 'vim-denops/denops-shared-server.vim'});

  //lsp
  await dvpm.add({ url: "neovim/nvim-lspconfig" });
  await dvpm.add({ url: "nvimdev/lspsaga.nvim" });
  await dvpm.add({ url: "williamboman/mason.nvim" });
  await dvpm.add({ url: "williamboman/mason-lspconfig.nvim" });
  await dvpm.add({ url: "WhoIsSethDaniel/mason-tool-installer.nvim" });
  await dvpm.add({ url: "neovim/nvim-lspconfig" });
  await dvpm.add({ url: "j-hui/fidget.nvim" });
  //java
  await dvpm.add({ url: "nvim-java/lua-async-await" });
  await dvpm.add({ url: "nvim-java/nvim-java-refactor" });
  await dvpm.add({ url: "nvim-java/nvim-java-core" });
  await dvpm.add({ url: "nvim-java/nvim-java-test" });
  await dvpm.add({ url: "nvim-java/nvim-java-dap" });
  await dvpm.add({ url: "MunifTanjim/nui.nvim" });
  await dvpm.add({ url: "mfussenegger/nvim-dap" });
  await dvpm.add({ url: "JavaHello/spring-boot.nvim" });
  await dvpm.add({ url: "nvim-java/nvim-java" });
  await dvpm.add({ url: "zk-org/zk-nvim" });
  await dvpm.add({ url: "nanotee/sqls.nvim" });
  await dvpm.add({ url: "stevearc/conform.nvim" });
  await dvpm.add({ url: "shougo/ddc.vim" });
  //filter
  await dvpm.add({ url: "shougo/ddc-matcher_head" });
  await dvpm.add({ url: "shougo/ddc-sorter_rank" });
  await dvpm.add({ url: "tani/ddc-fuzzy" });
  //ui
  await dvpm.add({ url: "shougo/ddc-ui-pum" });
  await dvpm.add({ url: "shougo/pum.vim" });
  //sources
  await dvpm.add({ url: "shougo/ddc-source-lsp" });
  await dvpm.add({ url: "shougo/ddc-source-around" });
  await dvpm.add({ url: "LumaKernel/ddc-source-file" });
  await dvpm.add({ url: "uga-rosa/ddc-source-lsp-setup" });
  await dvpm.add({ url: "matsui54/ddc-source-buffer" });
  await dvpm.add({ url: "uga-rosa/ddc-source-nvim-lua" });
  await dvpm.add({ url: "shougo/ddc-source-cmdline" });
  await dvpm.add({ url: "shougo/ddc-source-cmdline-history" });

  //ddc
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
    ],
  });
  //popup
  await dvpm.add({ url: "matsui54/denops-popup-preview.vim" });
  await dvpm.add({ url: "matsui54/denops-signature_help" });

  //ファイラ
  await dvpm.add({
    url: "lambdalisue/vim-fern",
    dependencies: [
      "yuki-yano/fern-preview.vim",
      "lambdalisue/vim-fern-git-status",
      "lambdalisue/vim-fern-hijack",
      "lambdalisue/vim-nerdfont",
      "lambdalisue/vim-fern-renderer-nerdfont",
    ],
    afterFile: "~/.config/nvim/plugin.d/fern.vim",
  });
  // await dvpm.add({ url: "yuki-yano/fern-preview.vim" });
  // await dvpm.add({ url: "lambdalisue/vim-fern-git-status" });
  // await dvpm.add({ url: "lambdalisue/vim-fern-hijack" });
  await dvpm.add({ url: "lambdalisue/vim-nerdfont" });
  await dvpm.add({ url: "lambdalisue/vim-fern-renderer-nerdfont" });
  await dvpm.add({ url: "stevearc/oil.nvim" });

  //ステータスラインプラグイン
  await dvpm.add({ url: "nvim-lualine/lualine.nvim" });
  await dvpm.add({ url: "nvim-tree/nvim-web-devicons" });
  //terminal
  await dvpm.add({ url: "chomosuke/term-edit.nvim" });
  await dvpm.add({ url: "akinsho/toggleterm.nvim" });
  //treesitter
  await dvpm.add({ url: "nvim-treesitter/nvim-treesitter" });
  await dvpm.add({ url: "nvim-treesitter/nvim-treesitter-context" });
  //git
  await dvpm.add({ url: "lambdalisue/vim-gin" });
  await dvpm.add({ url: "ogaken-1/nvim-gin-preview" });
  await dvpm.add({ url: "APZelos/blamer.nvim" });
  await dvpm.add({ url: "lewis6991/gitsigns.nvim" });
  await dvpm.add({ url: "isakbm/gitgraph.nvim" });
  await dvpm.add({ url: "sindrets/diffview.nvim" });

  //日本語
  await dvpm.add({ url: "lambdalisue/vim-kensaku" });
  await dvpm.add({ url: "lambdalisue/vim-kensaku-search" });
  await dvpm.add({ url: "vim-skk/skkeleton" });
  await dvpm.add({ url: "NI57721/skkeleton-state-popup" });

  //telescope
  await dvpm.add({ url: "nvim-lua/plenary.nvim" });
  await dvpm.add({ url: "nvim-telescope/telescope.nvim" });
  await dvpm.add({ url: "nvim-telescope/telescope-fzf-native.nvim" });
  await dvpm.add({ url: "kkharji/sqlite.lua" });
  await dvpm.add({ url: "danielfalk/smart-open.nvim" });
  await dvpm.add({ url: "atusy/qfscope.nvim" });
  await dvpm.add({ url: "cljoly/telescope-repo.nvim" });
  await dvpm.add({ url: "prochri/telescope-all-recent.nvim" });

  //便利系 useful
  await dvpm.add({ url: "kevinhwang91/nvim-bqf" });
  await dvpm.add({ url: "folke/which-key.nvim" });
  await dvpm.add({ url: "mattn/vim-sonictemplate" });
  await dvpm.add({ url: "thinca/vim-quickrun" });
  await dvpm.add({ url: "numToStr/comment.nvim" });
  await dvpm.add({ url: "folke/todo-comments.nvim" });
  await dvpm.add({ url: "yuki-yano/fuzzy-motion.vim" });
  await dvpm.add({ url: "ethanholz/nvim-lastplace" });
  await dvpm.add({ url: "haya14busa/vim-edgemotion" });
  await dvpm.add({ url: "shellRaining/hlchunk.nvim" });
  await dvpm.add({ url: "stevearc/aerial.nvim" });
  await dvpm.add({ url: "kevinhwang91/nvim-hlslens" });
  await dvpm.add({ url: "haya14busa/vim-asterisk" });
  await dvpm.add({ url: "0xAdk/full_visual_line.nvim" });
  // await dvpm.add({ url: "github/copilot.vim" });
  await dvpm.add({ url: "CopilotC-Nvim/CopilotChat.nvim" });
  await dvpm.add({ url: "tyru/capture.vim" });
  await dvpm.add({ url: "itchyny/vim-cursorword" });
  await dvpm.add({ url: "tyru/open-browser.vim" });
  await dvpm.add({ url: "lambdalisue/vim-guise" });
  await dvpm.add({ url: "lambdalisue/vim-suda" });
  await dvpm.add({ url: "johann2357/nvim-smartbufs" });
  await dvpm.add({ url: "MeanderingProgrammer/markdown.nvim" });
  await dvpm.add({ url: "mechatroner/rainbow_csv" });
  await dvpm.add({ url: "tkmpypy/chowcho.nvim" });
  await dvpm.add({
    url: "folke/styler.nvim",
    dependencies: ["edeneast/nightfox.nvim"],
    afterFile: "~/.config/nvim/plugin.d/styler.lua",
  });
  await dvpm.add({ url: "ahmedkhalf/project.nvim" });
  await dvpm.add({ url: "MeanderingProgrammer/markdown.nvim" });
  await dvpm.add({ url: "monaqa/dial.nvim" });
  await dvpm.add({ url: "nanotee/zoxide.vim" });
  await dvpm.add({ url: "tani/dmacro.nvim" });
  await dvpm.add({ url: "famiu/bufdelete.nvim" });
  await dvpm.add({ url: "simeji/winresizer" });
  //キャメルケース単位でのオブジェクト指定
  await dvpm.add({ url: "bkad/CamelCaseMotion" });
  //閉じ括弧の自動挿入
  await dvpm.add({ url: "cohama/lexima.vim" });
  //閉じタグの自動挿入
  await dvpm.add({ url: "windwp/nvim-ts-autotag" });
  //"(などで囲える
  await dvpm.add({ url: "tpope/vim-surround" });
  await dvpm.add({ url: "matukoto/fm-nvim" });
  //easymotion
  await dvpm.add({ url: "folke/flash.nvim" });
  await dvpm.add({ url: "machakann/vim-sandwich" });
  //WakaTime コーディング時間を計測してくれる
  await dvpm.add({ url: "wakatime/vim-wakatime" });

  //DB
  await dvpm.add({ url: "tpope/vim-dadbod" });
  await dvpm.add({ url: "kristijanhusak/vim-dadbod-ui" });

  //カラースキーマ
  await dvpm.add({ url: "gen740/SmoothCursor.nvim" });
  await dvpm.add({ url: "sainnhe/gruvbox-material" });
  await dvpm.add({ url: "sainnhe/edge" });
  await dvpm.add({ url: "sainnhe/sonokai" });
  await dvpm.add({ url: "sainnhe/everforest" });
  await dvpm.add({ url: "edeneast/nightfox.nvim" });
  await dvpm.add({ url: "AlexvZyl/nordic.nvim" });
  await dvpm.add({ url: "folke/tokyonight.nvim" });
  await dvpm.add({ url: "tanvirtin/monokai.nvim" });
  await dvpm.add({ url: "hachy/eva01.vim" });
  await dvpm.add({ url: "ray-x/aurora" });

  await dvpm.end();

  console.log("Load completed !");
}
