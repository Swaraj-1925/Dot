return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "saghen/blink.cmp",
  },
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true, -- enable treesitter integration
    })

    -- Integrate with blink.cmp instead of cmp
    local blink = require("blink.cmp")
    blink.setup({
      autopairs = { enable = true }, -- enable autopair integration
    })
  end,
}
