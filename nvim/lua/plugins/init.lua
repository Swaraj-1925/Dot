return {
  { 
    "nvim-lua/plenary.nvim",
    lazy = true, -- Only load when needed by other plugins
  },
  { 
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy", -- Load after startup
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux Navigate Left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux Navigate Down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux Navigate Up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux Navigate Right" },
    },
  },
  { 
    "nvim-tree/nvim-web-devicons",
    lazy = true, -- Only load when needed by other plugins
  },
}
