return {
  "saghen/blink.cmp",
  event = "InsertEnter", -- Only load when entering insert mode
  version = "*",
  dependencies = {
    "rafamadriz/friendly-snippets", -- Optional: for snippets
  },
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
    },

    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    },
     sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        buffer = {
          max_items = 4,
          min_keyword_length = 4,
        },
        path = {
          min_keyword_length = 3,
        },
        snippets = {
          min_keyword_length = 2,
        },
        lsp = {
          min_keyword_length = 1,
        },
      },
    },

    signature = {
      enabled = true,
    },
  },
}
