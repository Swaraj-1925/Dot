return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- mason main
    require("mason").setup({
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- ensure LSP servers
    require("mason-lspconfig").setup({
      ensure_installed = {
  "lua_ls",
  "bashls",
  "clangd",
  "cmake",
  "dockerls",
  "jsonls",
  "marksman",
  "pyright",
  "yamlls",
      },
      automatic_installation = true,
    })

    -- ensure external tools (formatters, linters, etc)
    require("mason-tool-installer").setup({
      ensure_installed = {
        "black",        -- Python formatter
        "clang-format", -- C/C++
        "eslint_d",
        "isort",
        "pylint",
        "prettier",
        "shfmt",
        "stylua",
      },
      auto_update = false,
      run_on_start = false,
    })
  end,
}
