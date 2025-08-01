local home = os.getenv('HOME')
local workspace_path = home .. '/.cache/jdtls/workspace/'
local os_name = 'linux' -- `linux`, `win` or `mac`
local root_dir = vim.fs.root(0, { 'mvnw', 'gradlew', '.git' })
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = workspace_path .. project_name

--- @type vim.lsp.Config
return {
  cmd = {
    home .. '/.local/share/mise/installs/java/corretto-17.0.14.7.1/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dosgi.sharedConfiguration.area=' .. home .. '/home/matsumoto/.local/share/nvim/mason/share/jdtls/config',
    '-Dosgi.sharedConfiguration.area.readOnly=true',
    '-Dosgi.configuration.cascaded=true',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_' .. os_name,
    '-data',
    workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
      },
      format = {
        settings = {
          url = vim.fn.expand('~/.config/jdtls/google-java-format.xml'),
          profile = 'GoogleStyle',
        },
      },
      saveActions = {
        organizeImports = true,
      },
    },
  },
}
