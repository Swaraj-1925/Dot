-- 2. Safely delete the old 'lazyvim_wrap_spell' group if it exists
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")

-- 3. Show cursorline only in active window
local cursor_group = vim.api.nvim_create_augroup("ActiveCursorLine", { clear = true })
vim.api.nvim_create_autocmd({"InsertLeave", "WinEnter"}, {
  group = cursor_group,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({"InsertEnter", "WinLeave"}, {
  group = cursor_group,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- 4. Better backup on write
local backup_group = vim.api.nvim_create_augroup("BetterBackup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = backup_group,
  callback = function(event)
    local file = vim.uv.fs_realpath(event.match) or event.match
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- 5. Filetype overrides
vim.filetype.add {
  extension = {
    overlay = "dts",
    keymap  = "dts",
  },
}

-- 6. Highlight on yank
local yank_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200, on_visual = true })
  end,
  desc = "Highlight yanked text",
})

-- 7. Remove trailing whitespace on save
local trim_group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = trim_group,
  pattern = "*",
  callback = function()
    -- silently trim any trailing spaces
    vim.cmd([[silent! %s/\s\+$//e]])
  end,
  desc = "Remove trailing whitespace on save",
})

-- Auto-create missing directories when opening a file
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(event)
        local file = event.match
        local dir = vim.fn.fnamemodify(file, ":p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end
})
