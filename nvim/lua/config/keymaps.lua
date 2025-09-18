vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("v", "<Tab>", ">gv", { desc = "Indent right" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Indent left" })

-- vim.keymap.set('i', '<C-/>', function()
--     require('Comment.api').toggle.linewise.current()
-- end, { desc = 'Comment current line' })

-- Normal mode (remap to built-in `gcc`)
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment (normal)" })

-- visule mode (remap to built-in `gc`)
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment (visual)" })
