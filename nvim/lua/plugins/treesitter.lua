return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "lua", "python", "c", "cpp", "markdown" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- Defer treesitter setup to improve startup
    vim.defer_fn(function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "vim",
          "dockerfile",
          "gitignore",
          "vimdoc",
          "c",
          "cpp",
          "python",
          "cmake",
          "ninja"
        },
        auto_install = false, -- Disable auto-install for faster startup
        sync_install = false, -- Install languages asynchronously
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        indent = {
          enable = true,
          disable = { "python" }, -- Python indentation is handled better by vim
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })
      -- Setup autotag after treesitter
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end, 50)
  end,
}
