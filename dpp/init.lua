local dpp_src = "$HOME/.cache/dpp/repos/github.com/dd/dpp.vim"

-- プラグイン内のluaモジュールを読み込むため先にruntimepathに追加する
vim.opt.runtimepath:append(dpp_src)
local dpp = require("dpp")

local dpp_base = "$HOME/.cache/dpp/"
local dpp_config = "$HOME/.config/nvim/dpp.ts"

local denops_src = "$HOME/.cache/dpp/repos/github.com/denops/denops.vim"

local ext_toml = "$HOME/.cache/dpp/repos/github.com/dd/dpp-ext-toml"
local ext_lazy = "$HOME/.cache/dpp/repos/github.com/dd/dpp-ext-lazy"
local ext_installer = "$HOME/.cache/dpp/repos/github.com/dd/dpp-ext-installer"
local ext_git = "$HOME/.cache/dpp/repos/github.com/dd/dpp-protocol-git"

vim.opt.runtimepath:append(ext_toml)
vim.opt.runtimepath:append(ext_lazy)
vim.opt.runtimepath:append(ext_installer)
vim.opt.runtimepath:append(ext_git)

vim.g.denops_server_addr = "127.0.0.1:34141"
vim.g["denops#debug"] = 1

if dpp.load_state(dpp_base) then
  vim.opt.runtimepath:prepend(denops_src)

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function()
      vim.notify("vim load_state is failed")
      dpp.make_state(dpp_base, dpp_config)
    end
  })
end

