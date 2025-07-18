return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup{
      -- Don't pack all testcases into one file
      testcases_use_single_file = false,
      -- Expand your shell's $HOME correctly:
      template_file              = "$(HOME)/cp/templates/cp_template.cpp",
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
  local opts = { silent = true, noremap = true, desc = 'Competitest' }
  map('n', '<leader>cg', '<cmd>CompetiTest receive problem<CR>', opts)
  map('n', '<leader>cr', '<cmd>CompetiTest run<CR>', opts)
  map('n', '<leader>cR', '<cmd>CompetiTest run_no_compile<CR>', opts)
  map('n', '<leader>cu', '<cmd>CompetiTest show_ui<CR>', opts)
  map('n', '<leader>ca', '<cmd>CompetiTest add_testcase<CR>', opts)
  map('n', '<leader>ce', '<cmd>CompetiTest edit_testcase<CR>', opts)
  map('n', '<leader>cd', '<cmd>CompetiTest delete_testcase<CR>', opts)
  end
}
