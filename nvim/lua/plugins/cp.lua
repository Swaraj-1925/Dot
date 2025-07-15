return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup{
      -- Don’t pack all testcases into one file
      testcases_use_single_file = false,

      -- Expand your shell’s $HOME correctly:
      received_problems_path     = "$(HOME)/cp/$(PROBLEM).$(FEXT)",
      template_file              = "$(HOME)/cp/templates/cp_template.cpp",
      evaluate_template_modifiers = true,

 -- Input goes in ~/cp/testcase/<ProblemName>/
            testcases_input_file_format    = "/testcase/$(FNOEXT)/$(FNOEXT)_input$(TCNUM).txt",

      -- Output goes in ~/cp/output/
            testcases_output_file_format   = "/output/$(FNOEXT)_output$(TCNUM).txt",


    }
  end
}
