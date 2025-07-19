return {
  {
    "stevearc/oil.nvim",
    default_file_explorer = true,
    delete_to_trash = true,
    -- skip_confirm_for_simple_edits = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set("n", "<leader>ee", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<leader>ef", require("oil").toggle_float)
    end,
  },
}
