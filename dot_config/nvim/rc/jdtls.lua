require('java').setup({
  -- load java test plugins
  java_test = {
    enable = false,
  },

  root_markers = {
    'settings.gradle',
    'settings.gradle.kts',
    'pom.xml',
    'build.gradle',
    'mvnw',
    'gradlew',
    'build.gradle',
  },

  -- load java debugger plugins
  java_debug_adapter = {
    enable = true,
  },

  spring_boot_tools = {
    enable = false,
  },

  jdk = {
    -- install jdk using mason.nvim
    auto_install = true,
  },

  notifications = {
    -- enable 'Configuring DAP' & 'DAP configured' messages on start up
    dap = false,
  },

  -- We do multiple verifications to make sure things are in place to run this
  -- plugin
  verification = {
    -- nvim-java checks for the order of execution of following
    -- * require('java').setup()
    -- * require('lspconfig').jdtls.setup()
    -- IF they are not executed in the correct order, you will see a error
    -- notification.
    -- Set following to false to disable the notification if you know what you
    -- are doing
    invalid_order = true,

    -- nvim-java checks if the require('java').setup() is called multiple
    -- times.
    -- IF there are multiple setup calls are executed, an error will be shown
    -- Set following property value to false to disable the notification if
    -- you know what you are doing
    duplicate_setup_calls = true,

    -- nvim-java checks if nvim-java/mason-registry is added correctly to
    -- mason.nvim plugin.
    -- IF it's not registered correctly, an error will be thrown and nvim-java
    -- will stop setup
    invalid_mason_registry = true,
  },
})

require('lspconfig').jdtls.setup({
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
})
