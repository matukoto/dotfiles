--- @type vim.lsp.Config
return {
  -- local home_dir = vim.env.HOME
  -- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
  -- local workspace_dir = home_dir .. '/.cache/nvim/jdtls/workspaces/' .. project_name
  -- cmd = {
  --   '/home/matsumoto/.local/share/mise/installs/java/corretto-17.0.14.7.1/bin/java',
  --   '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  --   '-Dosgi.bundles.defaultStartLevel=4',
  --   '-Declipse.product=org.eclipse.jdt.ls.core.product',
  --   '-Dosgi.checkConfiguration=true',
  --   '-Dosgi.sharedConfiguration.area=/home/matsumoto/.local/share/nvim/mason/share/jdtls/config',
  --   '-Dosgi.sharedConfiguration.area.readOnly=true',
  --   '-Dosgi.configuration.cascaded=true',
  --   '-Xms1G',
  --   '--add-modules=ALL-SYSTEM',
  --   '--add-opens',
  --   'java.base/java.util=ALL-UNNAMED',
  --   '--add-opens',
  --   'java.base/java.lang=ALL-UNNAMED',
  --   '-javaagent:/home/matsumoto/.local/share/nvim/mason/share/lombok-nightly/lombok.jar',
  --   '-jar',
  --   '/home/matsumoto/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
  --   '-configuration',
  --   '/home/matsumoto/.cache/nvim/jdtls/config',
  --   '-data',
  --   workspace_dir,
  -- },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
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
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
      saveActions = {
        organizeImports = true,
      },
    },
  },
}
