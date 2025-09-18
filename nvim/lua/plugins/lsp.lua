return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local keymap = vim.keymap

    -- Get capabilities from blink.cmp instead of cmp-nvim-lsp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Check if blink.cmp is available and get its capabilities
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end
    -- diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type })
    end
vim.diagnostic.config({
  virtual_text = {
    -- only show WARN and ERROR inline
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    -- only place gutter signs for WARN and ERROR
    severity = { min = vim.diagnostic.severity.WARN },
  },
  underline = {
    -- only underline WARN and ERROR
    severity = { min = vim.diagnostic.severity.WARN },
  },
  update_in_insert = false,
  severity_sort = true,
})
    -- on_attach for keymaps
    local on_attach = function(client, bufnr)
      local bufopts = { buffer = bufnr, silent = true }
      -- Telescope and built-in LSP commands
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", bufopts, { desc = "Go to definition" }))
      keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", bufopts)
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", bufopts)
      keymap.set({ "n","v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", bufopts)
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts)
      keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
      keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
      keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", bufopts)
    end

    -- Track which servers have been setup to avoid duplicates
    local setup_servers = {}

    -- Helper function to setup server if not already done
    local function setup_server(server_name)
      if not setup_servers[server_name] then
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
        setup_servers[server_name] = true
      end
    end

    -- Filetype to LSP server mapping
    local filetype_to_server = {
      python = "pyright",
      lua = "lua_ls",
      c = "clangd",
      cpp = "clangd",
      cmake = "cmake",
      sh = "bashls",
      bash = "bashls",
      zsh = "bashls",
      json = "jsonls",
      yaml = "yamlls",
      yml = "yamlls",
      markdown = "marksman",
      dockerfile = "dockerls",
    }

    -- Lazy-load LSP servers based on filetype
    local lsp_autocmd = vim.api.nvim_create_autocmd
    lsp_autocmd("FileType", {
      pattern = vim.tbl_keys(filetype_to_server),
      callback = function(ev)
        local ft = vim.bo[ev.buf].filetype
        local server = filetype_to_server[ft]
        if server then
          setup_server(server)
        end
      end,
    })

  end,
}
