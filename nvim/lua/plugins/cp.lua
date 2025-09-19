return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup{
      -- Don't pack all testcases into one file
      testcases_use_single_file = false,
      -- Expand your shell's $HOME correctly:
      template_file = vim.fn.expand("~/cp/templates/cp_template.cpp"),
      evaluate_template_modifiers = true,
      received_problems_path = function(task, file_extension)
        -- Extract problem ID from URL (e.g., "2120_A" from "https://codeforces.com/problemset/problem/2120/A")
        local problem_id = ""
        if task.url then
          local contest_num, problem_letter = task.url:match("/problem/(%d+)/(%w+)")
          if contest_num and problem_letter then
            problem_id = contest_num .. "_" .. problem_letter
          else
            -- Fallback to problem name if URL parsing fails
            problem_id = task.name:gsub("[^%w]", "_")
          end
        else
          problem_id = task.name:gsub("[^%w]", "_")
        end

        return string.format("%s/cp/%s/%s.%s", vim.loop.os_homedir(), problem_id, task.name, file_extension)
      end
    }
  local map = vim.keymap.set
  local opts = { silent = true, noremap = true}
    map('n', '<leader>cg', '<cmd>CompetiTest receive problem<CR>',
      { desc = 'Download problem from contest'})

    map('n', '<leader>cr', '<cmd>CompetiTest run<CR>',
      { desc = 'Compile & run solution with test cases'})

    map('n', '<leader>cR', '<cmd>CompetiTest run_no_compile<CR>',
      { desc = 'Run solution without compiling'})

    map('n', '<leader>cu', '<cmd>CompetiTest show_ui<CR>',
      { desc = 'Open CompetiTest UI menu'})

    map('n', '<leader>ca', '<cmd>CompetiTest add_testcase<CR>',
      { desc = 'Add a new testcase' })

    map('n', '<leader>ce', '<cmd>CompetiTest edit_testcase<CR>',
      { desc = 'Edit an existing testcase'})

    map('n', '<leader>cd', '<cmd>CompetiTest delete_testcase<CR>',
      { desc = 'Delete a testcase'})

  end
}
