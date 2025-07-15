return {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")
        
        -- Setup harpoon with custom settings
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                key = function()
                    return vim.loop.cwd()
                end,
            },
            default = {
                get_root_dir = function()
                    return vim.loop.cwd()
                end,
            },
        })

        -- Leader-based keybindings (more ergonomic)
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
        vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon menu" })
        
        -- Quick file access (1-4)
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Go to harpoon file 1" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Go to harpoon file 2" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Go to harpoon file 3" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Go to harpoon file 4" })
        vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Go to harpoon file 5" })
        
        -- Navigation keybindings
        vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end, { desc = "Go to previous harpoon file" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end, { desc = "Go to next harpoon file" })
        
        
        -- Quick management
        vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "Remove current file from harpoon" })
        vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end, { desc = "Clear harpoon list" })
        
        -- Quick replace current file
        vim.keymap.set("n", "<leader>ha", function() 
            harpoon:list():remove()
            harpoon:list():add()
        end, { desc = "Replace current file in harpoon" })
        
        
        -- Telescope integration (if you have telescope)
        local success, telescope = pcall(require, "telescope")
        if success then
            vim.keymap.set("n", "<leader>fh", function()
                local conf = require("telescope.config").values
                local file_paths = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(file_paths, item.value)
                end
                
                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end, { desc = "Search harpoon files with telescope" })
        end
    end,
    dependencies = { 
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim", -- optional, for telescope integration
    },
}
