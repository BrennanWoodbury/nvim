local Plugin = {'williamboman/mason.nvim'}

Plugin.lazy = false

-- See :help mason-settings
Plugin.opts = {
  ui = {border = 'rounded'},
  opts = {
      ensure_installed = {
          "ruff-lsp",
          "ruff",
          "black",
          "isort",
          "stylua",
          "shellcheck",
          "eslint",
          "prettier",
      }
  }
}

return Plugin

