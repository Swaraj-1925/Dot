-- Leader key (if needed elsewhere)
vim.g.mapleader = " "

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- General Editor Behavior
vim.opt.title = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.scrolloff = 10
vim.opt.mouse = ""
vim.opt.cmdheight = vim.fn.has("nvim-0.8") == 1 and 0 or 1
vim.opt.laststatus = 3
vim.opt.showcmd = true
vim.opt.cursorline = true
vim.cmd.colorscheme("habamax")


-- Clipboard
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Tabs & Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.breakindent = true

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- UI & Visuals
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- File Handling
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- Backup Directory (optional, can delete if not using backup)
vim.opt.backupdir = vim.fn.stdpath("state") .. "/backup"

-- Mouse
vim.opt.mousescroll = "ver:1,hor:4"

-- Filetype Rules
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- Format Options
vim.opt.formatoptions:append({ "r" }) -- Add `*` in block comments on Enter

-- LazyVim-specific Globals
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.ai_cmp = false
vim.g.deprecation_warnings = true

-- FZF Integration
vim.env.FZF_DEFAULT_OPTS = ""
