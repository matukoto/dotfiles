import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v5.0.0/mapping/mod.ts";
import { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import { ensureString } from "https://deno.land/x/unknownutil@v2.1.1/mod.ts";
import { execute } from "https://deno.land/x/denops_std@v5.0.0/helper/mod.ts";
import { globals } from "https://deno.land/x/denops_std@v5.0.0/variable/mod.ts";

import { Dvpm } from "https://deno.land/x/dvpm@1.0.0/mod.ts";

export async function main(denops: Denops): Promise<void> {
  // プラグインをインストールするベースとなるパスです。
  const base_path = (await fn.has(denops, "nvim"))
    ? "~/.cache/nvim/dvpm"
    : "~/.cache/vim/dvpm";
  const base = ensureString(await fn.expand(denops, base_path));

  // ベースパスを引数に、 Dvpm.begin を実行して、 `dvpm` インスタンスを取得します。
  const dvpm = await Dvpm.begin(denops, { base });

  // 以降は `dvpm.add` を用いて必要なプラグインを追加していきます。
  await dvpm.add({ url: "yukimemi/dps-autocursor" });

  // ブランチを指定することもできます。
  // await dvpm.add({ url: "neoclide/coc.nvim", branch: "release" });

  // build オプションでは、 `install` か `update` 実施後に実行する処理を記載できます。
  // `Denops` オブジェクト以外に、 `PlugInfo` オブジェクトを引数に取ることもできます。
  // 含まれている情報については README を参照ください。
  await dvpm.add({
    url: "neoclide/coc.nvim",
    branch: "master",
    build: async ({ info }) => {
      const args = ["install", "--frozen-lockfile"];
      const cmd = new Deno.Command("yarn", { args, cwd: info?.dst });
      const output = await cmd.output();
      console.log(new TextDecoder().decode(output.stdout));
    },
  });

  // `before` はプラグインが runtimepath へ追加される前に実行されます。
  await dvpm.add({
    url: "yukimemi/dps-autobackup",
    before: async ({ denops }) => {
      // `denops_std` の関数で Vim のグローバル変数をセットしています。
      // let g:autobackup_dir = "~/.cache/autobackup" と等価。
      await globals.set(
        denops,
        "autobackup_dir",
        ensureString(await fn.expand(denops, "~/.cache/autobackup")),
      );
    },
  });
  // `after` はプラグインを runtimepath へ追加した後に実行されます。
  await dvpm.add({
    url: "folke/which-key.nvim",
    after: async ({ denops }) => {
      // `denops_std` の関数 `execute` では Vim のコマンドがなんでも実行可能です。
      await execute(denops, `lua require("which-key").setup()`);
    },
  });

  // `dst` でベースパスとは別の場所にプラグインを clone することも可能です。
  // 開発時などに便利。
  await dvpm.add({
    url: "yukimemi/dps-randomcolorscheme",
    dst: "~/src/github.com/yukimemi/dps-randomcolorscheme",
    before: async ({ denops }) => {
      // `denops_std` の `mapping` 用関数を利用するとキーマッピング設定ができます。
      await mapping.map(denops, "<space>ro", "<cmd>ChangeColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(
        denops,
        "<space>rd",
        "<cmd>DisableThisColorscheme<cr>",
        { mode: "n" },
      );
      await mapping.map(denops, "<space>rl", "<cmd>LikeThisColorscheme<cr>", {
        mode: "n",
      });
      await mapping.map(denops, "<space>rh", "<cmd>HateThisColorscheme<cr>", {
        mode: "n",
      });
    },
  });
  //  プラグインの 有効 / 無効は `enabled` で切り替えることができます。
  await dvpm.add({
    url: "yukimemi/dps-hitori",
    enabled: false,
  });
  // `enabled` には関数指定もできるので 下記のように Vim だけ有効などの指定が可能です。
  await dvpm.add({
    url: "editorconfig/editorconfig-vim",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")),
  });
  // `dependencies` を指定することで、プラグインが runtimepath へ追加される順序を制御することができます。
  await dvpm.add({
    url: "kana/vim-textobj-entire",
    dependencies: [{ url: "kana/vim-textobj-user" }],
  });

  // 最後に dvpm.end を呼べば完了です。
  await dvpm.end();

  console.log("Load completed !");
}
