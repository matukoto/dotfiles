import type { Denops } from "jsr:@denops/std";
import * as fn from "jsr:@denops/std/function";
import * as mapping from "jsr:@denops/std/mapping";
import * as vars from "jsr:@denops/std/variable";
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

  // URL only (GitHub).
  await dvpm.add({ url: "yukimemi/autocursor.vim" });
  // URL only (not GitHub).
  await dvpm.add({ url: "https://notgithub.com/some/other/plugin" });
  // With branch.
  // await dvpm.add({ url: "neoclide/coc.nvim", branch: "release" });
  // build option. Execute after install or update.
  await dvpm.add({
    url: "neoclide/coc.nvim",
    branch: "master",
    build: async ({ info }) => {
      if (!info.isUpdate || !info.isLoad) {
        // build option is called after git pull, even if there are no changes
        // so you need to check for changes
        return;
      }
      const args = ["install", "--frozen-lockfile"];
      const cmd = new Deno.Command("yarn", { args, cwd: info.dst });
      const output = await cmd.output();
      console.log(new TextDecoder().decode(output.stdout));
    },
  });
  // shalow clone.
  await dvpm.add({ url: "yukimemi/chronicle.vim", depth: 1 });
  // before setting.
  await dvpm.add({
    url: "yukimemi/silentsaver.vim",
    before: async ({ denops }) => {
      await vars.g.set(
        denops,
        "silentsaver_dir",
        ensure(await fn.expand(denops, "~/.cache/nvim/silentsaver"), is.String),
      );
    },
  });
  // after setting.
  await dvpm.add({
    url: "folke/which-key.nvim",
    after: async ({ denops }) => {
      await execute(denops, `lua require("which-key").setup()`);
    },
  });
  // dst setting. (for develop)
  await dvpm.add({
    url: "yukimemi/spectrism.vim",
    dst: "~/src/github.com/yukimemi/spectrism.vim",
    before: async ({ denops }) => {
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
  // Disable setting.
  await dvpm.add({
    url: "yukimemi/hitori.vim",
    enabled: false,
  });
  // Disable with function.
  await dvpm.add({
    url: "editorconfig/editorconfig-vim",
    enabled: async ({ denops }) => !(await fn.has(denops, "nvim")),
  });
  // With dependencies. dependencies plugin must be added.
  await dvpm.add({ url: "lambdalisue/askpass.vim" });
  await dvpm.add({ url: "lambdalisue/guise.vim" });
  await dvpm.add({
    url: "lambdalisue/gin.vim",
    dependencies: ["lambdalisue/askpass.vim", "lambdalisue/guise.vim"],
  });
  // Load from file. ( `.lua` or `.vim` )
  await dvpm.add({
    url: "rcarriga/nvim-notify",
    beforeFile: "~/.config/nvim/rc/before/nvim-notify.lua",
    afterFile: "~/.config/nvim/rc/after/nvim-notify.lua",
  });

  // Finally, call Dvpm.end.
  await dvpm.end();

  console.log("Load completed !");
}
